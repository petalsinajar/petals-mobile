import 'package:flutter/widgets.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';

/// Springy shrink while a finger is down. Wrap tappable cards and buttons.
class PressScale extends StatefulWidget {
  const PressScale({required this.child, this.enabled = true, super.key});

  final Widget child;
  final bool enabled;

  @override
  State<PressScale> createState() => _PressScaleState();
}

class _PressScaleState extends State<PressScale> {
  var _pressed = false;

  void _set(bool pressed) {
    if (widget.enabled && _pressed != pressed) {
      setState(() => _pressed = pressed);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (context.reduceMotion) return widget.child;
    return Listener(
      onPointerDown: (_) => _set(true),
      onPointerUp: (_) => _set(false),
      onPointerCancel: (_) => _set(false),
      child: AnimatedScale(
        scale: _pressed ? AppMotion.pressedScale : 1,
        duration: AppMotion.fast,
        curve: _pressed ? AppMotion.standard : AppMotion.spring,
        child: widget.child,
      ),
    );
  }
}
