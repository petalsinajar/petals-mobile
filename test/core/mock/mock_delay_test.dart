import 'dart:math';

import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/mock/mock_delay.dart';

void main() {
  test('latency stays within 300–800 ms by default', () {
    final delay = MockDelay(random: Random(1));
    for (var i = 0; i < 200; i++) {
      final ms = delay.next().inMilliseconds;
      expect(ms, inInclusiveRange(300, 800));
    }
  });

  test('none() adds no latency', () async {
    final delay = MockDelay.none();
    expect(delay.next(), Duration.zero);
    expect(await delay.run(() => 42), 42);
  });

  test('run propagates errors after the delay', () async {
    await expectLater(
      MockDelay.none().run<int>(() => throw StateError('boom')),
      throwsStateError,
    );
  });
}
