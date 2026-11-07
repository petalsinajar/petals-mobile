import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:lottie/lottie.dart';
import 'package:petalsinajar/app/config/app_assets.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/widgets/async_value_view.dart';
import 'package:petalsinajar/core/widgets/empty_state.dart';
import 'package:petalsinajar/core/widgets/error_state.dart';
import 'package:petalsinajar/core/widgets/skeleton.dart';

import '../../helpers/pump_app.dart';

void main() {
  test('the bundled Lottie animation parses', () async {
    final bytes = await File(AppAssets.balloonsAnimation).readAsBytes();
    final composition = await LottieComposition.fromBytes(bytes);
    expect(composition.duration, greaterThan(Duration.zero));
  });

  group('EmptyState', () {
    testWidgets('shows copy and fires the action', (tester) async {
      var created = false;
      await tester.pumpApp(
        EmptyState(
          title: 'No events yet',
          message: 'Create your first one.',
          actionLabel: 'Create event',
          onAction: () => created = true,
        ),
      );
      await tester.pumpAndSettle();

      expect(find.text('No events yet'), findsOneWidget);
      expect(find.text('Create your first one.'), findsOneWidget);
      expect(find.byType(Lottie), findsOneWidget);
      await tester.tap(find.text('Create event'));
      expect(created, isTrue);
    });

    testWidgets('uses an icon instead of an animation', (tester) async {
      await tester.pumpApp(
        const EmptyState(title: 'Nothing', icon: Icons.inbox_rounded),
      );
      expect(find.byIcon(Icons.inbox_rounded), findsOneWidget);
      expect(find.byType(Lottie), findsNothing);
    });
  });

  group('ErrorState', () {
    testWidgets('explains network errors and retries', (tester) async {
      var retries = 0;
      await tester.pumpApp(
        ErrorState(
          error: const ApiException(
            type: ApiErrorType.network,
            message: 'down',
          ),
          onRetry: () => retries++,
        ),
      );

      expect(find.text("You're offline"), findsOneWidget);
      await tester.tap(find.text('Try again'));
      expect(retries, 1);
    });

    testWidgets('shows validation messages from the API', (tester) async {
      await tester.pumpApp(
        const ErrorState(
          error: ApiException(
            type: ApiErrorType.validation,
            message: 'Pick a date in the future.',
          ),
        ),
      );
      expect(find.text('Pick a date in the future.'), findsOneWidget);
      expect(find.text('Try again'), findsNothing);
    });
  });

  group('AsyncValueView', () {
    Widget view(AsyncValue<List<int>> value) => AsyncValueView<List<int>>(
      value: value,
      isEmpty: (d) => d.isEmpty,
      empty: const Text('empty'),
      onRetry: () {},
      data: (d) => Text('items: ${d.length}'),
    );

    testWidgets('loading → skeleton', (tester) async {
      await tester.pumpApp(view(const AsyncLoading()));
      expect(find.byType(SkeletonList), findsOneWidget);
    });

    testWidgets('data / empty / error', (tester) async {
      await tester.pumpApp(view(const AsyncData([1, 2])));
      expect(find.text('items: 2'), findsOneWidget);

      await tester.pumpApp(view(const AsyncData([])));
      expect(find.text('empty'), findsOneWidget);

      await tester.pumpApp(view(AsyncError(StateError('x'), StackTrace.empty)));
      expect(find.byType(ErrorState), findsOneWidget);
    });
  });
}
