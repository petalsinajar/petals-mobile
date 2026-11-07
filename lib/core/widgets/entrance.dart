import 'package:flutter/widgets.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';

/// Fade + slide-up entrance, staggered by [index] for lists.
/// Skipped entirely when the OS asks to reduce motion.
class Entrance extends StatelessWidget {
  const Entrance({required this.child, this.index = 0, super.key});

  final Widget child;
  final int index;

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return child;
    final slot = index.clamp(0, AppMotion.maxStaggeredItems);
    return child
        .animate(delay: AppMotion.stagger * slot)
        .fadeIn(duration: AppMotion.medium, curve: AppMotion.standard)
        .slideY(
          begin: AppMotion.entranceOffset,
          end: 0,
          duration: AppMotion.slow,
          curve: AppMotion.emphasized,
        );
  }
}

extension EntranceX on Widget {
  /// `PostCard(...).entrance(index)` in list builders.
  Widget entrance([int index = 0]) => Entrance(index: index, child: this);
}
