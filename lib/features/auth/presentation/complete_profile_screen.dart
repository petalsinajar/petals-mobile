import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/domain/handles.dart';
import 'package:petalsinajar/features/auth/presentation/auth_errors.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';

enum _HandleState { idle, checking, available, taken }

/// The one step after a first sign-in: a name, and a username suggested
/// from it. The router keeps new accounts here until a name is saved, then
/// moves on to where they were going.
class CompleteProfileScreen extends ConsumerStatefulWidget {
  const CompleteProfileScreen({super.key});

  /// Quiet time after typing before checking a username.
  static const checkDelay = Duration(milliseconds: 400);

  @override
  ConsumerState<CompleteProfileScreen> createState() =>
      _CompleteProfileScreenState();
}

class _CompleteProfileScreenState extends ConsumerState<CompleteProfileScreen> {
  final _name = TextEditingController();
  final _handle = TextEditingController();
  Timer? _debounce;

  /// Once the user types a username we stop suggesting one from the name.
  var _handleEdited = false;
  _HandleState _handleState = _HandleState.idle;
  var _saving = false;
  String? _nameError;
  String? _handleError;

  /// The placeholder handle the server gave the new account (`user4567`).
  String? get _currentHandle => ref.read(authSessionProvider).value?.handle;

  @override
  void dispose() {
    _debounce?.cancel();
    _name.dispose();
    _handle.dispose();
    super.dispose();
  }

  void _onNameChanged(String name) {
    setState(() => _nameError = null);
    if (_handleEdited) return;
    _handle.text = name.trim().isEmpty ? '' : suggestHandle(name);
    _scheduleCheck();
  }

  void _onHandleChanged(String _) {
    _handleEdited = true;
    _scheduleCheck();
  }

  void _scheduleCheck() {
    _debounce?.cancel();
    final handle = normalizeHandle(_handle.text);
    final problem = handle.isEmpty ? null : handleProblem(handle);
    setState(() {
      _handleError = problem;
      _handleState = handle.isEmpty || problem != null
          ? _HandleState.idle
          : handle == _currentHandle
          ? _HandleState.available
          : _HandleState.checking;
    });
    if (_handleState == _HandleState.checking) {
      _debounce = Timer(CompleteProfileScreen.checkDelay, () => _check(handle));
    }
  }

  /// Checks [handle]. A suggestion that's taken gets a number, like the
  /// backend does: `ama.mensah`, `ama.mensah2`, … up to 9.
  Future<void> _check(String handle) async {
    final repo = ref.read(authRepositoryProvider);
    final candidates = [
      handle,
      if (!_handleEdited)
        for (var i = 2; i <= 9; i++) '$handle$i',
    ];
    try {
      for (final candidate in candidates) {
        if (await repo.isHandleAvailable(candidate)) {
          if (!mounted || normalizeHandle(_handle.text) != handle) return;
          if (candidate != handle) _handle.text = candidate;
          setState(() => _handleState = _HandleState.available);
          return;
        }
      }
      if (!mounted || normalizeHandle(_handle.text) != handle) return;
      setState(() {
        _handleState = _HandleState.taken;
        _handleError = 'That username is taken. Try another.';
      });
    } on Object {
      // Offline or similar: the server checks again when saving.
      if (mounted) setState(() => _handleState = _HandleState.idle);
    }
  }

  Future<void> _save() async {
    final name = _name.text.trim();
    final handle = normalizeHandle(_handle.text);
    if (name.isEmpty) {
      setState(() => _nameError = 'Enter your name.');
      return;
    }
    if (handle.isNotEmpty && handleProblem(handle) != null) return;

    setState(() {
      _saving = true;
      _nameError = null;
    });
    try {
      // Keep the placeholder handle if they cleared the field.
      await ref
          .read(authSessionProvider.notifier)
          .completeProfile(
            displayName: name,
            handle: handle.isEmpty || handle == _currentHandle ? null : handle,
          );
      // The router moves on once the session has a name.
    } on Object catch (e) {
      if (!mounted) return;
      setState(() {
        if (e is ApiException && e.fieldError('handle') != null) {
          _handleError = e.fieldError('handle');
          _handleState = _HandleState.taken;
        } else {
          _nameError = authErrorText(e, field: 'display_name');
        }
      });
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final colors = context.colors;
    final handle = normalizeHandle(_handle.text);

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: _saving
                ? null
                : () => ref.read(authSessionProvider.notifier).signOut(),
            child: const Text('Sign out'),
          ),
        ],
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screen),
          children: [
            Text('What should we call you?', style: text.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'This is how hosts, guests and vendors will see you. '
              'You can change it later.',
              style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.xl),
            TextField(
              controller: _name,
              autofocus: true,
              enabled: !_saving,
              maxLength: 80,
              textCapitalization: TextCapitalization.words,
              textInputAction: TextInputAction.next,
              autofillHints: const [AutofillHints.name],
              decoration: InputDecoration(
                labelText: 'Your name',
                hintText: 'Ama Mensah',
                prefixIcon: const Icon(Icons.badge_rounded),
                counterText: '',
                errorText: _nameError,
              ),
              onChanged: _onNameChanged,
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(
              controller: _handle,
              enabled: !_saving,
              maxLength: 30,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9._@]')),
              ],
              decoration: InputDecoration(
                labelText: 'Username',
                prefixText: '@',
                hintText: _currentHandle,
                counterText: '',
                errorText: _handleError,
                helperText: switch (_handleState) {
                  _HandleState.available => '@$handle is yours to take.',
                  _HandleState.checking => 'Checking…',
                  _ => 'People can find you by your username.',
                },
                suffixIcon: switch (_handleState) {
                  _HandleState.checking => const Padding(
                    padding: EdgeInsets.all(AppSpacing.md),
                    child: SizedBox.square(
                      dimension: AppSizes.iconSm,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                  ),
                  _HandleState.available => Icon(
                    Icons.check_circle_rounded,
                    color: colors.primary,
                  ),
                  _ => null,
                },
              ),
              onChanged: _onHandleChanged,
              onSubmitted: (_) => _save(),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Continue',
              expand: true,
              size: AppButtonSize.large,
              isLoading: _saving,
              onPressed: _handleState == _HandleState.checking ? null : _save,
            ),
          ],
        ),
      ),
    );
  }
}
