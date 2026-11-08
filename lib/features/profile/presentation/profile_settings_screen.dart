import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';

/// Account details, privacy, and which notifications to get. Each switch
/// saves on its own.
class ProfileSettingsScreen extends ConsumerStatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  ConsumerState<ProfileSettingsScreen> createState() =>
      _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends ConsumerState<ProfileSettingsScreen> {
  /// The switch being saved, so it shows progress and can't be double-tapped.
  String? _saving;

  Future<void> _save(String key, ProfileChanges changes) async {
    setState(() => _saving = key);
    try {
      await ref.read(authSessionProvider.notifier).updateProfile(changes);
    } on Object catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Couldn't save: ${ErrorState.describe(e).$2}"),
        ),
      );
    } finally {
      if (mounted) setState(() => _saving = null);
    }
  }

  @override
  Widget build(BuildContext context) {
    final me = ref.watch(authSessionProvider).value;
    if (me == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    final notify = me.notify;

    Widget toggle({
      required String key,
      required String title,
      required String subtitle,
      required bool value,
      required ProfileChanges Function({required bool on}) change,
    }) => SwitchListTile(
      title: Text(title),
      subtitle: Text(subtitle),
      value: value,
      onChanged: _saving == null ? (on) => _save(key, change(on: on)) : null,
      secondary: _saving == key
          ? const SizedBox.square(
              dimension: AppSizes.iconMd,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : null,
    );

    return Scaffold(
      appBar: AppBar(title: const Text('Profile settings')),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        children: [
          const _Section('Account'),
          ListTile(
            leading: const Icon(Icons.phone_outlined),
            title: const Text('Phone number'),
            subtitle: Text(me.phone),
            trailing: Text(
              'Used to sign in',
              style: context.textTheme.bodySmall?.copyWith(
                color: context.colors.onSurfaceVariant,
              ),
            ),
          ),
          const _Section('Privacy'),
          toggle(
            key: 'private',
            title: 'Private account',
            subtitle: 'Only followers you approve see your posts.',
            value: me.isPrivate,
            change: ({required on}) => ProfileChanges(isPrivate: on),
          ),
          const _Section('Notifications'),
          toggle(
            key: 'push',
            title: 'Push notifications',
            subtitle: 'Likes, comments, RSVPs and booking updates.',
            value: notify.push,
            change: ({required on}) =>
                ProfileChanges(notify: notify.copyWith(push: on)),
          ),
          toggle(
            key: 'sms',
            title: 'Text messages',
            subtitle: 'Booking confirmations and reminders by SMS.',
            value: notify.sms,
            change: ({required on}) =>
                ProfileChanges(notify: notify.copyWith(sms: on)),
          ),
          toggle(
            key: 'suggestions',
            title: 'Vendor suggestions',
            subtitle: 'Ideas for rentals that fit your upcoming events.',
            value: notify.suggestions,
            change: ({required on}) =>
                ProfileChanges(notify: notify.copyWith(suggestions: on)),
          ),
        ],
      ),
    );
  }
}

class _Section extends StatelessWidget {
  const _Section(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.screen,
        AppSpacing.lg,
        AppSpacing.screen,
        AppSpacing.xs,
      ),
      child: Text(
        title,
        style: context.textTheme.labelLarge?.copyWith(
          color: context.colors.primary,
        ),
      ),
    );
  }
}
