import 'dart:async';

import 'package:flutter/material.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/features/events/domain/event.dart';

sealed class CountdownState {
  const CountdownState();

  factory CountdownState.of(Event event, DateTime now) {
    if (now.isBefore(event.startsAt)) {
      return CountdownTicking(event.startsAt.difference(now));
    }
    return now.isBefore(event.effectiveEndsAt)
        ? const CountdownLive()
        : const CountdownEnded();
  }
}

class CountdownTicking extends CountdownState {
  const CountdownTicking(this.remaining);

  final Duration remaining;

  int get days => remaining.inDays;
  int get hours => remaining.inHours % 24;
  int get minutes => remaining.inMinutes % 60;
  int get seconds => remaining.inSeconds % 60;
}

class CountdownLive extends CountdownState {
  const CountdownLive();
}

class CountdownEnded extends CountdownState {
  const CountdownEnded();
}

/// Days · hours · minutes · seconds until the event, ticking every second.
class EventCountdown extends StatefulWidget {
  const EventCountdown({required this.event, this.clock, super.key});

  final Event event;
  final DateTime Function()? clock;

  @override
  State<EventCountdown> createState() => _EventCountdownState();
}

class _EventCountdownState extends State<EventCountdown> {
  Timer? _timer;

  DateTime _now() => (widget.clock ?? DateTime.now)();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (CountdownState.of(widget.event, _now()) is CountdownEnded) {
        _timer?.cancel();
      }
      setState(() {});
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final accent = context.palette.accentFor(widget.event.type);
    final text = context.textTheme;
    final state = CountdownState.of(widget.event, _now());

    final child = switch (state) {
      CountdownTicking() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _Unit(value: state.days, label: 'days', color: accent.onContainer),
          _Unit(value: state.hours, label: 'hrs', color: accent.onContainer),
          _Unit(value: state.minutes, label: 'min', color: accent.onContainer),
          _Unit(value: state.seconds, label: 'sec', color: accent.onContainer),
        ],
      ),
      CountdownLive() => Text(
        'Happening now 🎉',
        style: text.titleMedium?.copyWith(color: accent.onContainer),
        textAlign: TextAlign.center,
      ),
      CountdownEnded() => Text(
        'This event has ended',
        style: text.titleSmall?.copyWith(color: accent.onContainer),
        textAlign: TextAlign.center,
      ),
    };

    return DecoratedBox(
      decoration: BoxDecoration(
        color: accent.container,
        borderRadius: AppRadii.cardAll,
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: AppSpacing.lg,
          horizontal: AppSpacing.md,
        ),
        child: child,
      ),
    );
  }
}

class _Unit extends StatelessWidget {
  const _Unit({required this.value, required this.label, required this.color});

  final int value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final text = context.textTheme;
    return Semantics(
      label: '$value $label',
      excludeSemantics: true,
      child: Column(
        children: [
          Text(
            value.toString().padLeft(2, '0'),
            style: text.headlineMedium?.copyWith(
              color: color,
              fontFeatures: const [FontFeature.tabularFigures()],
            ),
          ),
          Text(
            label,
            style: text.labelSmall?.copyWith(
              color: context.colors.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
