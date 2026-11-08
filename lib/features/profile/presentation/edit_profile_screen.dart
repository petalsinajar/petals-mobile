import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/features/auth/domain/handles.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:petalsinajar/features/auth/presentation/auth_session.dart';

/// Picks a photo; replaceable in tests, where there's no gallery.
typedef PhotoPicker = Future<String?> Function();

Future<String?> _pickFromGallery() async {
  final file = await ImagePicker().pickImage(
    source: ImageSource.gallery,
    maxWidth: 1024,
    imageQuality: 85,
  );
  return file?.path;
}

/// Edit the photo, name, username, bio and city. Only what changed is sent;
/// a new photo is uploaded on save.
///
/// Waits for the session first: opened from a link at launch, it can be
/// built while the profile is still being restored.
class EditProfileScreen extends ConsumerWidget {
  const EditProfileScreen({this.pickPhoto = _pickFromGallery, super.key});

  final PhotoPicker pickPhoto;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final me = ref.watch(authSessionProvider).value;
    if (me == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Edit profile')),
        body: const Center(child: CircularProgressIndicator()),
      );
    }
    return _EditProfileForm(me: me, pickPhoto: pickPhoto);
  }
}

class _EditProfileForm extends ConsumerStatefulWidget {
  const _EditProfileForm({required this.me, required this.pickPhoto});

  /// The profile as it was when the form opened; edits are measured
  /// against it.
  final Me me;
  final PhotoPicker pickPhoto;

  @override
  ConsumerState<_EditProfileForm> createState() => _EditProfileFormState();
}

class _EditProfileFormState extends ConsumerState<_EditProfileForm> {
  late final Me _me = widget.me;
  late final _name = TextEditingController(text: _me.displayName);
  late final _handle = TextEditingController(text: _me.handle);
  late final _bio = TextEditingController(text: _me.bio ?? '');
  late final _city = TextEditingController(text: _me.city ?? '');
  String? _photoPath;
  var _saving = false;
  final _errors = <String, String>{};

  @override
  void dispose() {
    _name.dispose();
    _handle.dispose();
    _bio.dispose();
    _city.dispose();
    super.dispose();
  }

  /// Only the fields that differ from the saved profile.
  ProfileChanges get _changes {
    String? changed(String value, String? saved) =>
        value.trim() == (saved ?? '') ? null : value.trim();
    return ProfileChanges(
      displayName: changed(_name.text, _me.displayName),
      handle: changed(normalizeHandle(_handle.text), _me.handle),
      bio: changed(_bio.text, _me.bio),
      city: changed(_city.text, _me.city),
    );
  }

  bool get _hasChanges =>
      _photoPath != null || _changes != const ProfileChanges();

  Future<void> _choosePhoto() async {
    final path = await widget.pickPhoto();
    if (path != null && mounted) setState(() => _photoPath = path);
  }

  Future<void> _save() async {
    final errors = <String, String>{
      if (_name.text.trim().isEmpty) 'display_name': 'Enter your name.',
      'handle': ?handleProblem(_handle.text),
    };
    setState(() {
      _errors
        ..clear()
        ..addAll(errors);
    });
    if (errors.isNotEmpty || !_hasChanges) return;

    setState(() => _saving = true);
    try {
      await ref
          .read(authSessionProvider.notifier)
          .updateProfile(_changes, photoPath: _photoPath);
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('Profile saved')));
      context.pop();
    } on ApiException catch (e) {
      if (!mounted) return;
      setState(() {
        for (final field in ['display_name', 'handle', 'bio', 'city']) {
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
    const gap = SizedBox(height: AppSpacing.md);
    final name = _name.text.trim().isEmpty ? _me.handle : _name.text;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit profile'),
        actions: [
          TextButton(
            onPressed: _saving ? null : _save,
            child: _saving
                ? const SizedBox.square(
                    dimension: AppSizes.iconSm,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  )
                : const Text('Save'),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screen),
        children: [
          Center(
            child: GestureDetector(
              onTap: _saving ? null : _choosePhoto,
              child: Stack(
                children: [
                  if (_photoPath case final path?)
                    ClipOval(
                      child: Image.file(
                        File(path),
                        width: AvatarSize.xl.dimension,
                        height: AvatarSize.xl.dimension,
                        fit: BoxFit.cover,
                      ),
                    )
                  else
                    Avatar(
                      name: name,
                      imageUrl: _me.avatarUrl,
                      size: AvatarSize.xl,
                    ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: CircleAvatar(
                      radius: 16,
                      backgroundColor: context.colors.primary,
                      child: Icon(
                        Icons.photo_camera_rounded,
                        size: AppSizes.iconSm,
                        color: context.colors.onPrimary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Center(
            child: TextButton(
              onPressed: _saving ? null : _choosePhoto,
              child: const Text('Change photo'),
            ),
          ),
          if (_errors['form'] case final message?)
            Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: Text(
                message,
                style: TextStyle(color: context.colors.error),
              ),
            ),
          TextField(
            controller: _name,
            enabled: !_saving,
            maxLength: 80,
            textCapitalization: TextCapitalization.words,
            textInputAction: TextInputAction.next,
            decoration: InputDecoration(
              labelText: 'Name',
              counterText: '',
              errorText: _errors['display_name'],
            ),
            onChanged: (_) => setState(() {}),
          ),
          gap,
          TextField(
            controller: _handle,
            enabled: !_saving,
            maxLength: 30,
            autocorrect: false,
            textInputAction: TextInputAction.next,
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[A-Za-z0-9._@]')),
            ],
            decoration: InputDecoration(
              labelText: 'Username',
              prefixText: '@',
              counterText: '',
              errorText: _errors['handle'],
            ),
          ),
          gap,
          TextField(
            controller: _bio,
            enabled: !_saving,
            maxLength: 300,
            minLines: 2,
            maxLines: 5,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              labelText: 'Bio',
              hintText: 'Planning my dream wedding · Accra',
              alignLabelWithHint: true,
              errorText: _errors['bio'],
            ),
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
        ],
      ),
    );
  }
}
