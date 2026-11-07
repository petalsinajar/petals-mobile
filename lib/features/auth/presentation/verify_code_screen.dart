import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/features/auth/data/auth_mock_source.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/presentation/auth_errors.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:pinput/pinput.dart';

/// Step 2 of sign in: the code texted to [phone]. Submits on the sixth
/// digit. Once the session is signed in the router leaves this screen.
class VerifyCodeScreen extends ConsumerStatefulWidget {
  const VerifyCodeScreen({required this.phone, super.key});

  /// As the server normalised it, e.g. `+233240000001`.
  final String phone;

  /// How long before "Resend code" is offered.
  static const resendAfter = Duration(seconds: 30);

  @override
  ConsumerState<VerifyCodeScreen> createState() => _VerifyCodeScreenState();
}

class _VerifyCodeScreenState extends ConsumerState<VerifyCodeScreen> {
  final _code = TextEditingController();
  final _focus = FocusNode();
  Timer? _ticker;
  int _resendIn = VerifyCodeScreen.resendAfter.inSeconds;
  var _verifying = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _startResendCountdown();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _code.dispose();
    _focus.dispose();
    super.dispose();
  }

  void _startResendCountdown() {
    _ticker?.cancel();
    setState(() => _resendIn = VerifyCodeScreen.resendAfter.inSeconds);
    _ticker = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_resendIn <= 1) t.cancel();
      setState(() => _resendIn--);
    });
  }

  Future<void> _verify(String code) async {
    setState(() {
      _verifying = true;
      _error = null;
    });
    try {
      await ref
          .read(authSessionProvider.notifier)
          .verify(phone: widget.phone, code: code);
    } on Object catch (e) {
      if (!mounted) return;
      _code.clear();
      _focus.requestFocus();
      setState(() => _error = authErrorText(e, field: 'code'));
    } finally {
      if (mounted) setState(() => _verifying = false);
    }
  }

  Future<void> _resend() async {
    _startResendCountdown();
    setState(() => _error = null);
    try {
      await ref.read(authRepositoryProvider).requestOtp(widget.phone);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('New code sent.')));
    } on Object catch (e) {
      if (mounted) setState(() => _error = authErrorText(e, field: 'phone'));
    }
  }

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final colors = context.colors;
    final useMocks = ref.watch(appConfigProvider).useMocks;

    final box = PinTheme(
      width: 48,
      height: 56,
      textStyle: text.headlineSmall,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: AppRadii.mdAll,
        border: Border.all(color: colors.outlineVariant),
      ),
    );

    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.screen),
          children: [
            Text('Enter the code', style: text.headlineSmall),
            const SizedBox(height: AppSpacing.sm),
            Text(
              'We texted a 6-digit code to ${widget.phone}.',
              style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant),
            ),
            if (useMocks) ...[
              const SizedBox(height: AppSpacing.xs),
              Text(
                'Demo mode: the code is ${AuthMockSource.devCode}.',
                style: text.bodySmall?.copyWith(color: colors.primary),
              ),
            ],
            const SizedBox(height: AppSpacing.xl),
            Center(
              child: Pinput(
                length: 6,
                controller: _code,
                focusNode: _focus,
                autofocus: true,
                enabled: !_verifying,
                defaultPinTheme: box,
                focusedPinTheme: box.copyBorderWith(
                  border: Border.all(color: colors.primary, width: 2),
                ),
                errorPinTheme: box.copyBorderWith(
                  border: Border.all(color: colors.error),
                ),
                forceErrorState: _error != null,
                errorText: _error,
                onCompleted: _verify,
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            if (_verifying)
              const Center(child: CircularProgressIndicator())
            else
              Center(
                child: TextButton(
                  onPressed: _resendIn > 0 ? null : _resend,
                  child: Text(
                    _resendIn > 0
                        ? 'Resend code in ${_resendIn}s'
                        : 'Resend code',
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
