import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/core/widgets/skeleton.dart';

/// The one way screens render an [AsyncValue]: skeleton while loading,
/// [ErrorState] with retry on failure, [empty] when there's nothing to show.
///
/// On refresh the previous data stays on screen (pull-to-refresh shows its
/// own spinner), so lists don't flash back to skeletons.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    required this.value,
    required this.data,
    this.loading,
    this.onRetry,
    this.isEmpty,
    this.empty,
    this.error,
    super.key,
  });

  final AsyncValue<T> value;
  final Widget Function(T data) data;
  final Widget? loading;
  final VoidCallback? onRetry;
  final bool Function(T data)? isEmpty;
  final Widget? empty;

  /// Replaces the standard [ErrorState] when the screen needs more than retry.
  final Widget? error;

  @override
  Widget build(BuildContext context) {
    return value.when(
      data: (d) =>
          empty != null && (isEmpty?.call(d) ?? false) ? empty! : data(d),
      error: (e, _) => error ?? ErrorState(error: e, onRetry: onRetry),
      loading: () => loading ?? const SkeletonList(),
    );
  }
}
