import 'dart:async';
import 'dart:math';

import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/features/events/domain/event.dart';
import 'package:petalsinajar/features/events/presentation/event_labels.dart';
import 'package:petalsinajar/features/events/presentation/widgets/event_cover.dart';

/// "It's happening!" — confetti, the new event's card, and the way forward.
class EventCreatedView extends StatefulWidget {
  const EventCreatedView({
    required this.event,
    required this.onOpen,
    super.key,
  });

  final Event event;
  final VoidCallback onOpen;

  @override
  State<EventCreatedView> createState() => _EventCreatedViewState();
}

class _EventCreatedViewState extends State<EventCreatedView> {
  final _confetti = ConfettiController(duration: const Duration(seconds: 2));

  @override
  void initState() {
    super.initState();
    unawaited(Haptics.success());
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && !context.reduceMotion) _confetti.play();
    });
  }

  @override
  void dispose() {
    _confetti.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final event = widget.event;
    final text = context.textTheme;
    final accent = context.palette.accentFor(event.type);

    Widget content = Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text("It's happening!", style: text.displaySmall),
        const SizedBox(height: AppSpacing.sm),
        Text(
          '${event.title}\n${EventDates.startLine(event.startsAt)}',
          textAlign: TextAlign.center,
          style: text.titleMedium?.copyWith(color: accent.onContainer),
        ),
        const SizedBox(height: AppSpacing.xl),
        AspectRatio(
          aspectRatio: 16 / 9,
          child: Hero(
            tag: eventCoverHeroTag(event.id),
            child: EventCover(
              type: event.type,
              cover: event.cover,
              borderRadius: AppRadii.cardAll,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: 'Open event page',
          icon: Icons.arrow_forward_rounded,
          size: AppButtonSize.large,
          expand: true,
          onPressed: widget.onOpen,
        ),
      ],
    );
    if (!context.reduceMotion) {
      content = content
          .animate()
          .scale(
            begin: const Offset(0.85, 0.85),
            duration: AppMotion.celebrate,
            curve: AppMotion.bouncy,
          )
          .fadeIn(duration: AppMotion.medium);
    }

    return Stack(
      children: [
        Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.xl),
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: AppSizes.maxContentWidth,
              ),
              child: content,
            ),
          ),
        ),
        Align(
          alignment: Alignment.topCenter,
          child: ConfettiWidget(
            confettiController: _confetti,
            blastDirection: pi / 2,
            blastDirectionality: BlastDirectionality.explosive,
            emissionFrequency: 0.06,
            numberOfParticles: 24,
            gravity: 0.25,
            colors: context.palette.celebration,
          ),
        ),
      ],
    );
  }
}
