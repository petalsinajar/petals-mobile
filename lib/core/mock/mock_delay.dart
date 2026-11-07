import 'dart:math';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mock_delay.g.dart';

/// Simulated network latency for mock sources, so loading states (skeletons,
/// spinners, optimistic updates) are visible while running on seed data.
class MockDelay {
  MockDelay({
    this.min = const Duration(milliseconds: 300),
    this.max = const Duration(milliseconds: 800),
    Random? random,
  }) : assert(min <= max, 'min must not exceed max'),
       _random = random ?? Random();

  /// No latency — for tests.
  MockDelay.none() : this(min: Duration.zero, max: Duration.zero);

  final Duration min;
  final Duration max;
  final Random _random;

  /// The next latency to apply, uniformly between [min] and [max].
  Duration next() {
    final spread = max.inMilliseconds - min.inMilliseconds;
    return min +
        Duration(milliseconds: spread == 0 ? 0 : _random.nextInt(spread + 1));
  }

  Future<void> call() {
    final delay = next();
    return delay == Duration.zero ? Future.value() : Future.delayed(delay);
  }

  /// Waits, then returns [compute]'s result (or throws its error).
  Future<T> run<T>(T Function() compute) async {
    await call();
    return compute();
  }
}

@Riverpod(keepAlive: true)
MockDelay mockDelay(Ref ref) => MockDelay();
