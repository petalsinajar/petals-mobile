import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/session/active_actor.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/features/auth/domain/handles.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:petalsinajar/features/vendor/data/vendor_repository_impl.dart';
import 'package:petalsinajar/features/vendor/domain/vendor_models.dart';
import 'package:petalsinajar/features/vendor/presentation/vendor_controllers.dart';

/// "Start a business": name, @username, city, what you rent out and for
/// which events. The signed-in user becomes the owner, and the app switches
/// to vendor mode.
class StartBusinessScreen extends ConsumerStatefulWidget {
  const StartBusinessScreen({super.key});

  static const eventTypes = {
    'wedding': 'Weddings',
    'birthday': 'Birthdays',
    'corporate': 'Corporate',
    'other': 'Other events',
  };

  @override
  ConsumerState<StartBusinessScreen> createState() =>
      _StartBusinessScreenState();
}

class _StartBusinessScreenState extends ConsumerState<StartBusinessScreen> {
  final _name = TextEditingController();
  final _handle = TextEditingController();
  final _city = TextEditingController();
  final _categories = <String>{};
  final _eventTypes = <String>{};
  final _errors = <String, String>{};
  Timer? _debounce;
  var _handleEdited = false;

  /// null: not checked yet (or checking).
  bool? _handleFree;
  var _saving = false;

  @override
  void dispose() {
    _debounce?.cancel();
    _name.dispose();
    _handle.dispose();
    _city.dispose();
    super.dispose();
  }

  void _onNameChanged(String name) {
    setState(() => _errors.remove('name'));
    if (_handleEdited) return;
    _handle.text = name.trim().isEmpty ? '' : suggestHandle(name);
    _scheduleCheck();
  }

  void _scheduleCheck() {
    _debounce?.cancel();
    final handle = normalizeHandle(_handle.text);
    final problem = handle.isEmpty ? null : handleProblem(handle);
    setState(() {
      _handleFree = null;
      if (problem != null) {
        _errors['handle'] = problem;
      } else {
        _errors.remove('handle');
      }
    });
    if (handle.isEmpty || problem != null) return;
    _debounce = Timer(const Duration(milliseconds: 400), () async {
      try {
        final free = await ref
            .read(vendorRepositoryProvider)
            .isHandleAvailable(handle);
        if (!mounted || normalizeHandle(_handle.text) != handle) return;
        setState(() {
          _handleFree = free;
          if (!free) _errors['handle'] = 'That username is taken.';
        });
      } on Object {
        // Offline or similar: the server checks again on submit.
      }
    });
  }

  Future<void> _submit() async {
    final name = _name.text.trim();
    final handle = normalizeHandle(_handle.text);
    setState(() {
      _errors
        ..remove('form')
        ..addAll({
          if (name.isEmpty) 'name': 'Enter your business name.',
          if (handle.isEmpty) 'handle': 'Choose a username.',
        });
      final problem = handle.isEmpty ? null : handleProblem(handle);
      if (problem != null) _errors['handle'] = problem;
    });
    if (_errors.isNotEmpty) return;

    setState(() => _saving = true);
    try {
      final business = await ref
          .read(vendorRepositoryProvider)
          .startBusiness(
            NewBusiness(
              name: name,
              handle: handle,
              city: _city.text,
              categoryIds: _categories.toList(),
              eventTypes: _eventTypes.toList(),
            ),
          );
      // The new business joins the user's vendors.
      await ref.read(authSessionProvider.notifier).refresh();
      ref
          .read(activeActorProvider.notifier)
          .actAsVendor(
            vendorId: business.id,
            name: business.name,
            logoUrl: business.logoUrl,
          );
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('${business.name} is ready. Welcome!')),
      );
      context.go(Routes.vendorToday);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        for (final field in ['name', 'handle', 'city']) {
          if (e.fieldError(field) case final message?) _errors[field] = message;
        }
        if (_errors.isEmpty) _errors['form'] = ErrorState.describe(e).$2;
      });
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final colors = context.colors;
    final categories = ref.watch(businessCategoriesProvider);
    const gap = SizedBox(height: AppSpacing.md);
    final handle = normalizeHandle(_handle.text);

    return Scaffold(
      appBar: AppBar(title: const Text('Start a business')),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screen),
          children: [
            Text(
              'Rent out chairs, tents, décor or sound to hosts on '
              'Petalsinajar. You can switch between your account and your '
              'business any time.',
              style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (_errors['form'] case final message?)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: Text(message, style: TextStyle(color: colors.error)),
              ),
            TextField(
              controller: _name,
              enabled: !_saving,
              maxLength: 120,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'Business name',
                hintText: 'Royal Canopies & Chairs',
                counterText: '',
                errorText: _errors['name'],
              ),
              onChanged: _onNameChanged,
            ),
            gap,
            TextField(
              controller: _handle,
              enabled: !_saving,
              maxLength: 30,
              autocorrect: false,
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9._@]')),
              ],
              decoration: InputDecoration(
                labelText: 'Username',
                prefixText: '@',
                counterText: '',
                errorText: _errors['handle'],
                helperText: _handleFree ?? false
                    ? '@$handle is yours to take.'
                    : 'Hosts find your business by this.',
                suffixIcon: _handleFree ?? false
                    ? Icon(Icons.check_circle_rounded, color: colors.primary)
                    : null,
              ),
              onChanged: (_) {
                _handleEdited = true;
                _scheduleCheck();
              },
            ),
            gap,
            TextField(
              controller: _city,
              enabled: !_saving,
              maxLength: 80,
              textCapitalization: TextCapitalization.words,
              decoration: InputDecoration(
                labelText: 'City',
                hintText: 'Accra',
                prefixIcon: const Icon(Icons.place_outlined),
                counterText: '',
                errorText: _errors['city'],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('What do you rent out?', style: text.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            categories.when(
              loading: () => const LinearProgressIndicator(),
              error: (_, _) => TextButton.icon(
                onPressed: () => ref.invalidate(businessCategoriesProvider),
                icon: const Icon(Icons.refresh_rounded),
                label: const Text("Couldn't load categories. Retry"),
              ),
              data: (list) => Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.sm,
                children: [
                  for (final c in list)
                    FilterChip(
                      label: Text(c.name),
                      selected: _categories.contains(c.id),
                      onSelected: _saving
                          ? null
                          : (on) => setState(
                              () => on
                                  ? _categories.add(c.id)
                                  : _categories.remove(c.id),
                            ),
                    ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Text('For which events?', style: text.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final MapEntry(:key, :value)
                    in StartBusinessScreen.eventTypes.entries)
                  FilterChip(
                    label: Text(value),
                    selected: _eventTypes.contains(key),
                    onSelected: _saving
                        ? null
                        : (on) => setState(
                            () => on
                                ? _eventTypes.add(key)
                                : _eventTypes.remove(key),
                          ),
                  ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Create business',
              expand: true,
              size: AppButtonSize.large,
              isLoading: _saving,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}
