import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';

/// Email and password for the vendors' web dashboard. The app signs in by
/// phone; the dashboard needs a password, so vendors set one here.
class DashboardSignInScreen extends ConsumerStatefulWidget {
  const DashboardSignInScreen({super.key});

  static const dashboardUrl = 'https://petalsinajar.com/vendor';

  /// The backend's rule: 10+ characters, letters and numbers.
  static String? passwordProblem(String password) {
    if (password.length < 10) return 'Use at least 10 characters.';
    if (!RegExp('[A-Za-z]').hasMatch(password) ||
        !RegExp('[0-9]').hasMatch(password)) {
      return 'Use both letters and numbers.';
    }
    return null;
  }

  @override
  ConsumerState<DashboardSignInScreen> createState() =>
      _DashboardSignInScreenState();
}

class _DashboardSignInScreenState extends ConsumerState<DashboardSignInScreen> {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _errors = <String, String>{};
  var _obscure = true;
  var _saving = false;

  /// Set once saved: shows where to sign in.
  String? _savedEmail;

  @override
  void initState() {
    super.initState();
    _email.text = ref.read(authSessionProvider).value?.email ?? '';
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final email = _email.text.trim();
    final password = _password.text;
    setState(() {
      _errors
        ..clear()
        ..addAll({
          if (!RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$').hasMatch(email))
            'email': 'Enter a valid email address.',
          'password': ?DashboardSignInScreen.passwordProblem(password),
        });
    });
    if (_errors.isNotEmpty) return;

    setState(() => _saving = true);
    try {
      await ref
          .read(authSessionProvider.notifier)
          .setDashboardSignIn(email: email, password: password);
      if (mounted) setState(() => _savedEmail = email);
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        for (final field in ['email', 'password']) {
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
    final muted = text.bodyMedium?.copyWith(color: colors.onSurfaceVariant);

    if (_savedEmail case final email?) {
      return Scaffold(
        appBar: AppBar(title: const Text('Web dashboard sign-in')),
        body: ListView(
          padding: const EdgeInsets.all(AppSpacing.screen),
          children: [
            Icon(
              Icons.check_circle_rounded,
              size: AppSizes.iconLg,
              color: colors.primary,
            ),
            const SizedBox(height: AppSpacing.md),
            Text('Sign-in saved', style: text.titleLarge),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'On a computer, go to the address below and sign in with '
              '$email and your new password.',
              style: muted,
            ),
            const SizedBox(height: AppSpacing.lg),
            Card(
              child: ListTile(
                leading: const Icon(Icons.language_rounded),
                title: const Text(DashboardSignInScreen.dashboardUrl),
                trailing: IconButton(
                  tooltip: 'Copy link',
                  icon: const Icon(Icons.copy_rounded),
                  onPressed: () async {
                    await Clipboard.setData(
                      const ClipboardData(
                        text: DashboardSignInScreen.dashboardUrl,
                      ),
                    );
                    if (!context.mounted) return;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Link copied')),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Web dashboard sign-in')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screen),
        children: [
          Text(
            'Manage inventory, prices and bookings on a bigger screen at '
            'petalsinajar.com/vendor. The app signs you in by phone; the '
            'website needs an email and password.',
            style: muted,
          ),
          const SizedBox(height: AppSpacing.xl),
          if (_errors['form'] case final message?)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(message, style: TextStyle(color: colors.error)),
            ),
          TextField(
            controller: _email,
            enabled: !_saving,
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            autofillHints: const [AutofillHints.email],
            decoration: InputDecoration(
              labelText: 'Email',
              prefixIcon: const Icon(Icons.email_outlined),
              errorText: _errors['email'],
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          TextField(
            controller: _password,
            enabled: !_saving,
            obscureText: _obscure,
            autocorrect: false,
            autofillHints: const [AutofillHints.newPassword],
            decoration: InputDecoration(
              labelText: 'New password',
              helperText: 'At least 10 characters, with letters and numbers.',
              prefixIcon: const Icon(Icons.lock_outline_rounded),
              errorText: _errors['password'],
              suffixIcon: IconButton(
                tooltip: _obscure ? 'Show password' : 'Hide password',
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onPressed: () => setState(() => _obscure = !_obscure),
              ),
            ),
            onSubmitted: (_) => _save(),
          ),
          const SizedBox(height: AppSpacing.xl),
          AppButton(
            label: 'Save sign-in',
            expand: true,
            size: AppButtonSize.large,
            isLoading: _saving,
            onPressed: _save,
          ),
        ],
      ),
    );
  }
}
