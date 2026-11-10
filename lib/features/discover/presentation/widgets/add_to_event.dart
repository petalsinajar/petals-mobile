import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:petalsinajar/app/router/routes.dart';
import 'package:petalsinajar/app/session/viewer.dart';
import 'package:petalsinajar/app/theme/app_spacing.dart';
import 'package:petalsinajar/app/theme/theme_context.dart';
import 'package:petalsinajar/core/utils/haptics.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/inline_error.dart';
import 'package:petalsinajar/features/cart/domain/cart_line.dart';
import 'package:petalsinajar/features/cart/presentation/cart_controller.dart';
import 'package:petalsinajar/features/discover/domain/discover_models.dart';
import 'package:petalsinajar/features/discover/presentation/discover_controllers.dart';

/// Adds [package] to the cart of an event the viewer hosts. With one such
/// event it's a single tap; with several, a sheet asks which.
Future<void> addPackageToEvent(
  BuildContext context,
  WidgetRef ref,
  PackageCard package,
) async {
  if (ref.read(viewerIdProvider) == null) {
    unawaited(context.push(Routes.signInFrom(Routes.discover)));
    return;
  }
  unawaited(Haptics.light());

  final messenger = ScaffoldMessenger.of(context);
  List<UpcomingEvent> hosting;
  try {
    hosting = (await ref.read(
      myUpcomingEventsProvider.future,
    )).where((e) => e.isHost).toList();
  } on Object {
    hosting = const [];
  }
  if (!context.mounted) return;

  final event = hosting.length == 1
      ? hosting.single
      : await showModalBottomSheet<UpcomingEvent>(
          context: context,
          showDragHandle: true,
          builder: (_) => const _ChooseEventSheet(),
        );
  if (event == null) return;

  await ref
      .read(cartProvider.notifier)
      .add(
        CartLine(
          eventId: event.id,
          kind: CartLineKind.package,
          refId: package.id,
          title: package.title,
          priceMinor: package.priceMinor,
          currency: package.currency,
          vendorId: package.vendor?.id,
          vendorName: package.vendor?.name,
        ),
      );
  unawaited(Haptics.success());
  messenger.showSnackBar(
    SnackBar(content: Text('Added ${package.title} to ${event.title}')),
  );
}

class _ChooseEventSheet extends ConsumerWidget {
  const _ChooseEventSheet();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final events = ref.watch(myUpcomingEventsProvider);
    final day = DateFormat('EEE d MMM');
    return SafeArea(
      child: events.when(
        loading: () => const Padding(
          padding: EdgeInsets.all(AppSpacing.xxl),
          child: Center(child: CircularProgressIndicator()),
        ),
        error: (e, _) => Padding(
          padding: AppSpacing.screenPadding,
          child: InlineError(
            error: e,
            onRetry: () => ref.invalidate(myUpcomingEventsProvider),
          ),
        ),
        data: (all) {
          final hosting = all.where((e) => e.isHost).toList();
          if (hosting.isEmpty) {
            return EmptyState(
              title: 'Plan an event first',
              message: 'Packages go into the cart of an event you host.',
              icon: Icons.celebration_rounded,
              actionLabel: 'Create an event',
              onAction: () {
                Navigator.of(context).pop();
                unawaited(context.push(Routes.createEvent));
              },
            );
          }
          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: AppSpacing.screenPadding,
                child: Text(
                  'Add to which event?',
                  style: context.textTheme.titleLarge,
                ),
              ),
              for (final e in hosting)
                ListTile(
                  leading: const Icon(Icons.event_rounded),
                  title: Text(e.title),
                  subtitle: Text(day.format(e.startsAt)),
                  onTap: () => Navigator.of(context).pop(e),
                ),
            ],
          );
        },
      ),
    );
  }
}
