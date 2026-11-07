import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/motion.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/features/events/domain/event_draft.dart';
import 'package:petalsinajar/features/events/presentation/create/event_created_view.dart';
import 'package:petalsinajar/features/events/presentation/create/steps_basics.dart';
import 'package:petalsinajar/features/events/presentation/create/steps_details.dart';
import 'package:petalsinajar/features/events/presentation/events_controllers.dart';

/// `/events/new`: one question per page, then confetti.
class CreateEventScreen extends ConsumerStatefulWidget {
  const CreateEventScreen({super.key});

  @override
  ConsumerState<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends ConsumerState<CreateEventScreen> {
  static const List<EventDraftStep> _steps = EventDraftStep.values;
  final _pages = PageController();
  var _index = 0;

  EventDraftStep get _step => _steps[_index];
  bool get _isLast => _index == _steps.length - 1;

  @override
  void dispose() {
    _pages.dispose();
    super.dispose();
  }

  void _goTo(int index) {
    FocusScope.of(context).unfocus();
    setState(() => _index = index);
    final duration = context.reduceMotion ? Duration.zero : AppMotion.medium;
    if (duration == Duration.zero) {
      _pages.jumpToPage(index);
    } else {
      unawaited(
        _pages.animateToPage(
          index,
          duration: duration,
          curve: AppMotion.emphasized,
        ),
      );
    }
  }

  Future<void> _next() async {
    if (!_isLast) return _goTo(_index + 1);
    final draft = ref.read(eventDraftControllerProvider);
    await ref.read(createEventProvider.notifier).submit(draft);
  }

  void _back() => _index == 0 ? context.pop() : _goTo(_index - 1);

  @override
  Widget build(BuildContext context) {
    final draft = ref.watch(eventDraftControllerProvider);
    final submission = ref.watch(createEventProvider);

    ref.listen(createEventProvider, (_, next) {
      if (next case AsyncError(:final error)) {
        final (_, title, message) = ErrorState.describe(error);
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('$title. $message')));
      }
    });

    if (submission.value case final created?) {
      return Scaffold(
        body: SafeArea(
          child: EventCreatedView(
            event: created,
            onOpen: () => context.pushReplacement(
              Routes.event(created.id),
              extra: created,
            ),
          ),
        ),
      );
    }

    final text = context.textTheme;
    return PopScope(
      canPop: _index == 0,
      onPopInvokedWithResult: (didPop, _) {
        if (!didPop) _back();
      },
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            tooltip: _index == 0 ? 'Close' : 'Back',
            icon: Icon(
              _index == 0 ? Icons.close_rounded : Icons.arrow_back_rounded,
            ),
            onPressed: _back,
          ),
          title: Text('New event · ${_index + 1} of ${_steps.length}'),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(AppSpacing.xs),
            child: TweenAnimationBuilder<double>(
              tween: Tween(end: (_index + 1) / _steps.length),
              duration: AppMotion.medium,
              curve: AppMotion.standard,
              builder: (_, value, _) => LinearProgressIndicator(value: value),
            ),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.screen,
                AppSpacing.xl,
                AppSpacing.screen,
                0,
              ),
              child: Text(_titles[_step]!, style: text.headlineSmall),
            ),
            Expanded(
              child: PageView(
                controller: _pages,
                physics: const NeverScrollableScrollPhysics(),
                children: const [
                  TypeStep(),
                  TitleStep(),
                  DateTimeStep(),
                  VenueStep(),
                  GuestsStep(),
                  VisibilityStep(),
                  CoverStep(),
                ],
              ),
            ),
            SafeArea(
              top: false,
              minimum: const EdgeInsets.all(AppSpacing.screen),
              child: AppButton(
                label: _isLast ? 'Create event' : 'Next',
                icon: _isLast ? Icons.celebration_rounded : null,
                size: AppButtonSize.large,
                expand: true,
                isLoading: submission.isLoading,
                onPressed: draft.isStepValid(_step) ? _next : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  static const Map<EventDraftStep, String> _titles = {
    EventDraftStep.type: 'What are you celebrating?',
    EventDraftStep.title: 'Give it a name',
    EventDraftStep.dateTime: 'When is it?',
    EventDraftStep.venue: 'Where is it?',
    EventDraftStep.guests: 'How many guests?',
    EventDraftStep.visibility: 'Who can see it?',
    EventDraftStep.cover: 'Add a cover photo',
  };
}
