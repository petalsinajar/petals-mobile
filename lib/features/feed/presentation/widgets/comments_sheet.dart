import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/utils/time_ago.dart';
import 'package:petalsinajar/core/widgets/avatar.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/core/widgets/inline_error.dart';
import 'package:petalsinajar/features/feed/domain/post.dart';
import 'package:petalsinajar/features/feed/presentation/feed_controllers.dart';

/// A post's comments in a bottom sheet, with a box to add one.
///
/// [canComment] is false when signed out: the box becomes a sign-in prompt,
/// handled by [onSignIn].
class CommentsSheet extends ConsumerStatefulWidget {
  const CommentsSheet({
    required this.postId,
    required this.canComment,
    required this.onAdded,
    required this.onSignIn,
    super.key,
  });

  final String postId;
  final bool canComment;
  final VoidCallback onAdded;
  final VoidCallback onSignIn;

  @override
  ConsumerState<CommentsSheet> createState() => _CommentsSheetState();
}

class _CommentsSheetState extends ConsumerState<CommentsSheet> {
  final _body = TextEditingController();
  var _sending = false;
  String? _error;

  @override
  void dispose() {
    _body.dispose();
    super.dispose();
  }

  Future<void> _send() async {
    final body = _body.text.trim();
    if (body.isEmpty || _sending) return;
    setState(() {
      _sending = true;
      _error = null;
    });
    try {
      await ref.read(postCommentsProvider(widget.postId).notifier).add(body);
      _body.clear();
      widget.onAdded();
    } on Object catch (e) {
      if (mounted) {
        setState(
          () => _error = e is ApiException && e.fieldError('body') != null
              ? e.fieldError('body')
              : ErrorState.describe(e).$2,
        );
      }
    } finally {
      if (mounted) setState(() => _sending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = postCommentsProvider(widget.postId);
    final comments = ref.watch(provider);
    final text = context.textTheme;
    final muted = context.colors.onSurfaceVariant;

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.6,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (context, scroll) => Padding(
        // Keep the input above the keyboard.
        padding: EdgeInsets.only(
          bottom: MediaQuery.viewInsetsOf(context).bottom,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.md),
              child: Text('Comments', style: text.titleMedium),
            ),
            const Divider(height: 1),
            Expanded(
              child: comments.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: InlineError(
                    error: e,
                    onRetry: () => ref.invalidate(provider),
                  ),
                ),
                data: (page) => page.isEmpty
                    ? Center(
                        child: Text(
                          'No comments yet. Say something nice.',
                          style: text.bodyMedium?.copyWith(color: muted),
                        ),
                      )
                    : ListView.builder(
                        controller: scroll,
                        padding: const EdgeInsets.all(AppSpacing.screen),
                        itemCount: page.items.length + (page.hasMore ? 1 : 0),
                        itemBuilder: (context, i) {
                          if (i == page.items.length) {
                            return TextButton(
                              onPressed: () =>
                                  ref.read(provider.notifier).loadMore(),
                              child: const Text('Load more'),
                            );
                          }
                          return _CommentTile(comment: page.items[i]);
                        },
                      ),
              ),
            ),
            const Divider(height: 1),
            SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: widget.canComment
                    ? TextField(
                        controller: _body,
                        enabled: !_sending,
                        maxLength: 1000,
                        minLines: 1,
                        maxLines: 4,
                        textCapitalization: TextCapitalization.sentences,
                        decoration: InputDecoration(
                          hintText: 'Add a comment…',
                          counterText: '',
                          errorText: _error,
                          suffixIcon: _sending
                              ? const Padding(
                                  padding: EdgeInsets.all(AppSpacing.md),
                                  child: SizedBox.square(
                                    dimension: AppSizes.iconSm,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : IconButton(
                                  tooltip: 'Post comment',
                                  icon: const Icon(Icons.send_rounded),
                                  onPressed: _send,
                                ),
                        ),
                        onSubmitted: (_) => _send(),
                      )
                    : TextButton(
                        onPressed: widget.onSignIn,
                        child: const Text('Sign in to comment'),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment});

  final PostComment comment;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    final muted = context.colors.onSurfaceVariant;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Avatar(
            name: comment.author.name,
            imageUrl: comment.author.avatarUrl,
            isVendor: comment.author.isVendor,
            size: AvatarSize.sm,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        comment.author.name,
                        style: text.titleSmall,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    Text(
                      TimeAgo.format(comment.createdAt),
                      style: text.bodySmall?.copyWith(color: muted),
                    ),
                  ],
                ),
                Text(comment.body, style: text.bodyMedium),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
