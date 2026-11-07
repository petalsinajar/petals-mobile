import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/widgets/app_button.dart';

import '../../helpers/pump_app.dart';

void main() {
  testWidgets('calls onPressed when tapped', (tester) async {
    var taps = 0;
    await tester.pumpApp(
      AppButton(label: 'Rent this', onPressed: () => taps++),
    );

    await tester.tap(find.text('Rent this'));
    expect(taps, 1);
  });

  testWidgets('loading shows a spinner and ignores taps', (tester) async {
    var taps = 0;
    await tester.pumpApp(
      AppButton(label: 'Pay', isLoading: true, onPressed: () => taps++),
    );

    expect(find.byType(CircularProgressIndicator), findsOneWidget);
    await tester.tap(find.byType(AppButton), warnIfMissed: false);
    expect(taps, 0);
  });

  testWidgets('keeps its width while loading', (tester) async {
    Future<double> widthWith({required bool loading}) async {
      await tester.pumpApp(
        Center(
          child: AppButton(
            label: 'Confirm booking',
            isLoading: loading,
            onPressed: () {},
          ),
        ),
      );
      return tester.getSize(find.byType(FilledButton)).width;
    }

    final idle = await widthWith(loading: false);
    final loading = await widthWith(loading: true);
    expect(loading, idle);
  });

  testWidgets('variants render the matching Material button', (tester) async {
    await tester.pumpApp(
      Column(
        children: [
          AppButton(
            label: 'a',
            variant: AppButtonVariant.outline,
            onPressed: () {},
          ),
          AppButton(
            label: 'b',
            variant: AppButtonVariant.ghost,
            onPressed: () {},
          ),
        ],
      ),
    );
    expect(find.byType(OutlinedButton), findsOneWidget);
    expect(find.byType(TextButton), findsOneWidget);
  });
}
