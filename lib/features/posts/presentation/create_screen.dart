import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/features/posts/domain/post_draft.dart';
import 'package:petalsinajar/features/posts/presentation/create_post_controller.dart';
import 'package:petalsinajar/features/posts/presentation/photo_source.dart';
import 'package:petalsinajar/features/posts/presentation/widgets/draft_preview.dart';
import 'package:petalsinajar/features/posts/presentation/widgets/photo_tagger.dart';

/// The Create tab: pick photos, tag what you rented, write a caption,
/// choose who sees it, share.
class CreateScreen extends ConsumerWidget {
  const CreateScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final draft = ref.watch(createPostProvider);
    return draft.photos.isEmpty ? const _PickPhotos() : _Editor(draft: draft);
  }
}

Future<void> _addFromGallery(WidgetRef ref) async {
  final room =
      CreatePost.maxPhotos - ref.read(createPostProvider).photos.length;
  final picked = await ref.read(photoSourceProvider).gallery(limit: room);
  if (picked.isNotEmpty) {
    ref.read(createPostProvider.notifier).addPhotos(picked);
  }
}

Future<void> _addFromCamera(WidgetRef ref, {bool video = false}) async {
  final source = ref.read(photoSourceProvider);
  final picked = video ? await source.recordVideo() : await source.camera();
  if (picked != null) ref.read(createPostProvider.notifier).addPhotos([picked]);
}

class _PickPhotos extends ConsumerWidget {
  const _PickPhotos();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('New post')),
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: AppSizes.maxContentWidth,
            ),
            child: Column(
              children: [
                Icon(
                  Icons.add_a_photo_rounded,
                  size: AppSizes.iconLg * 2,
                  color: context.colors.primary,
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'Share a moment',
                  style: context.textTheme.headlineSmall,
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Post photos from your events and tag what you rented, so '
                  'others can shop the look.',
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label: 'Choose photos',
                  icon: Icons.photo_library_rounded,
                  expand: true,
                  onPressed: () => _addFromGallery(ref),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Take a photo',
                  icon: Icons.photo_camera_rounded,
                  variant: AppButtonVariant.outline,
                  expand: true,
                  onPressed: () => _addFromCamera(ref),
                ),
                const SizedBox(height: AppSpacing.sm),
                AppButton(
                  label: 'Record a video',
                  icon: Icons.videocam_rounded,
                  variant: AppButtonVariant.ghost,
                  expand: true,
                  onPressed: () => _addFromCamera(ref, video: true),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _Editor extends ConsumerStatefulWidget {
  const _Editor({required this.draft});

  final PostDraft draft;

  @override
  ConsumerState<_Editor> createState() => _EditorState();
}

class _EditorState extends ConsumerState<_Editor> {
  late final _caption = TextEditingController(text: widget.draft.caption);

  @override
  void dispose() {
    _caption.dispose();
    super.dispose();
  }

  CreatePost get _notifier => ref.read(createPostProvider.notifier);

  Future<void> _share() async {
    // Sharing clears the draft, which takes this editor off screen: hold on
    // to what's needed afterwards.
    final messenger = ScaffoldMessenger.of(context);
    final router = GoRouter.of(context);
    try {
      // Returns as soon as the files are queued; they upload in the
      // background and the post appears when they're ready.
      await _notifier.share();
      unawaited(Haptics.success());
      router.go(Routes.feed);
      messenger.showSnackBar(
        const SnackBar(content: Text('Posting… it’s uploading in the feed')),
      );
    } on ApiException catch (e) {
      unawaited(Haptics.warning());
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            e.fieldErrors.values.expand((m) => m).firstOrNull ?? e.message,
          ),
        ),
      );
    }
  }

  Future<void> _discard() async {
    final sure = await showDialog<bool>(
      context: context,
      builder: (dialog) => AlertDialog(
        title: const Text('Discard this post?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialog).pop(false),
            child: const Text('Keep editing'),
          ),
          TextButton(
            onPressed: () => Navigator.of(dialog).pop(true),
            child: const Text('Discard'),
          ),
        ],
      ),
    );
    if (sure ?? false) {
      _caption.clear();
      _notifier.discard();
    }
  }

  @override
  Widget build(BuildContext context) {
    final draft = widget.draft;
    final busy = draft.isBusy;
    final hasItemTags = draft.tags.any(
      (t) => t.target.type == TagTargetType.item,
    );
    final hint = draft.tags.isEmpty
        ? 'Tap a photo to tag the chairs, decor or vendors in it.'
        : hasItemTags
        ? 'Item tags show to others once the vendor approves them.'
        : 'Tap a tag to remove it.';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: 'Discard',
          icon: const Icon(Icons.close_rounded),
          onPressed: busy ? null : _discard,
        ),
        title: const Text('New post'),
      ),
      body: ListView(
        children: [
          PhotoTagger(
            photos: draft.photos,
            tags: draft.tags,
            enabled: !busy,
            onTag: _notifier.addTag,
            onUntag: _notifier.removeTag,
          ),
          _Thumbnails(draft: draft),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screen),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  hint,
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colors.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                TextField(
                  controller: _caption,
                  enabled: !busy,
                  minLines: 2,
                  maxLines: 6,
                  maxLength: 2200,
                  textCapitalization: TextCapitalization.sentences,
                  decoration: const InputDecoration(
                    labelText: 'Caption',
                    hintText: 'Tell the story… #wedding #accra',
                  ),
                  onChanged: _notifier.setCaption,
                ),
                const SizedBox(height: AppSpacing.sm),
                _Options(draft: draft),
                const SizedBox(height: AppSpacing.xl),
                AppButton(
                  label: 'Share',
                  icon: Icons.send_rounded,
                  expand: true,
                  isLoading: busy,
                  onPressed: draft.canShare ? _share : null,
                ),
                const SizedBox(height: AppSpacing.xl),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Small previews with remove buttons, and "+" to add more.
class _Thumbnails extends ConsumerWidget {
  const _Thumbnails({required this.draft});

  static const _size = 64.0;

  final PostDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(createPostProvider.notifier);
    final canAdd = draft.photos.length < CreatePost.maxPhotos && !draft.isBusy;
    return SizedBox(
      height: _size + AppSpacing.lg,
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.screen,
          AppSpacing.sm,
          AppSpacing.screen,
          0,
        ),
        children: [
          for (final (i, photo) in draft.photos.indexed)
            Padding(
              padding: const EdgeInsets.only(right: AppSpacing.md),
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  ClipRRect(
                    borderRadius: AppRadii.smAll,
                    child: SizedBox.square(
                      dimension: _size,
                      child: DraftPreview(photo: photo),
                    ),
                  ),
                  if (!draft.isBusy)
                    Positioned(
                      top: -AppSpacing.md,
                      right: -AppSpacing.md,
                      child: IconButton(
                        visualDensity: VisualDensity.compact,
                        iconSize: AppSizes.iconSm,
                        tooltip: 'Remove photo ${i + 1}',
                        style: IconButton.styleFrom(
                          backgroundColor: context.colors.surface,
                        ),
                        onPressed: () => notifier.removePhoto(i),
                        icon: const Icon(Icons.close_rounded),
                      ),
                    ),
                ],
              ),
            ),
          if (canAdd)
            SizedBox.square(
              dimension: _size,
              child: OutlinedButton(
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.zero,
                  shape: const RoundedRectangleBorder(
                    borderRadius: AppRadii.smAll,
                  ),
                ),
                onPressed: () => _addFromGallery(ref),
                child: const Icon(
                  Icons.add_rounded,
                  semanticLabel: 'Add photos',
                ),
              ),
            ),
        ],
      ),
    );
  }
}

/// Posting as, event, and who can see it.
class _Options extends ConsumerWidget {
  const _Options({required this.draft});

  final PostDraft draft;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.read(createPostProvider.notifier);
    final identities = ref.watch(postingIdentitiesProvider);
    final events = ref.watch(postableEventsProvider).value ?? const [];
    final busy = draft.isBusy;
    final day = DateFormat('d MMM yyyy');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (identities.length > 1) ...[
          DropdownButtonFormField<String?>(
            initialValue: draft.asVendorId,
            isExpanded: true,
            decoration: const InputDecoration(labelText: 'Posting as'),
            items: [
              for (final who in identities)
                DropdownMenuItem(
                  value: who.vendorId,
                  child: Row(
                    children: [
                      Avatar(
                        name: who.name,
                        imageUrl: who.avatarUrl,
                        size: AvatarSize.xs,
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Flexible(
                        child: Text(who.name, overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),
            ],
            onChanged: busy ? null : notifier.setIdentity,
          ),
          const SizedBox(height: AppSpacing.md),
        ],
        DropdownButtonFormField<PostableEvent?>(
          initialValue: draft.event,
          isExpanded: true,
          decoration: const InputDecoration(labelText: 'Event'),
          items: [
            const DropdownMenuItem(child: Text('Not linked to an event')),
            for (final e in events)
              DropdownMenuItem(
                value: e,
                child: Text(
                  '${e.title} · ${day.format(e.startsAt)}',
                  overflow: TextOverflow.ellipsis,
                ),
              ),
          ],
          onChanged: busy ? null : notifier.setEvent,
        ),
        const SizedBox(height: AppSpacing.md),
        Text('Who can see this', style: context.textTheme.labelLarge),
        const SizedBox(height: AppSpacing.xs),
        SegmentedButton<PostVisibility>(
          showSelectedIcon: false,
          segments: [
            const ButtonSegment(
              value: PostVisibility.public,
              label: Text('Everyone'),
            ),
            const ButtonSegment(
              value: PostVisibility.followers,
              label: Text('Followers'),
            ),
            ButtonSegment(
              value: PostVisibility.eventMembers,
              label: const Text('Guests'),
              enabled: draft.event != null,
            ),
          ],
          selected: {draft.visibility},
          onSelectionChanged: busy
              ? null
              : (s) {
                  unawaited(Haptics.selection());
                  notifier.setVisibility(s.first);
                },
        ),
      ],
    );
  }
}
