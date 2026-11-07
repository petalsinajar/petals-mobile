import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/presentation/auth_errors.dart';

/// Step 1 of sign in: the phone number to text a code to. Signing in for
/// the first time creates the account, so there's no separate sign up.
class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({this.from, super.key});

  /// Where to go once signed in.
  final String? from;

  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _phone = TextEditingController();
  var _sending = false;
  String? _error;

  @override
  void dispose() {
    _phone.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final phone = _phone.text.trim();
    if (phone.isEmpty) {
      setState(() => _error = 'Enter your phone number.');
      return;
    }
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      final challenge = await ref
          .read(authRepositoryProvider)
          .requestOtp(phone);
      if (!mounted) return;
      await context.push(
        Routes.verifyCodeFor(phone: challenge.phone, from: widget.from),
      );
    } on Object catch (e) {
      if (mounted) setState(() => _error = authErrorText(e, field: 'phone'));
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    return Scaffold(
      appBar: AppBar(
        leading: CloseButton(
          onPressed: () =>
              context.canPop() ? context.pop() : context.go(Routes.feed),
        ),
      ),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screen),
          children: [
            Text('Sign in to Petalsinajar', style: text.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              "Enter your phone number and we'll text you a 6-digit code. "
              'New here? This creates your account.',
              style: text.bodyMedium?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            TextField(
              controller: _phone,
              autofocus: true,
              enabled: !_sending,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.telephoneNumber],
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'[\d+ ]')),
              ],
              decoration: InputDecoration(
                labelText: 'Phone number',
                hintText: '024 123 4567',
                helperText: 'Ghana numbers can start with 0.',
                prefixIcon: const Icon(Icons.phone_rounded),
                errorText: _error,
              ),
              onSubmitted: (_) => _send(),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppButton(
              label: 'Send code',
              expand: true,
              size: AppButtonSize.large,
              isLoading: _sending,
              onPressed: _send,
            ),
          ],
        ),
      ),
    );
  }
}
