import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/utils/time_ago.dart';

void main() {
  final now = DateTime(2026, 10, 11, 12);

  String ago(Duration d) => TimeAgo.format(now.subtract(d), now: now);

  test('short relative times within a week', () {
    expect(ago(const Duration(seconds: 10)), 'now');
    expect(ago(const Duration(minutes: 5)), '5m');
    expect(ago(const Duration(hours: 3)), '3h');
    expect(ago(const Duration(days: 1)), '1d');
    expect(ago(const Duration(days: 3)), '3d');
  });

  test('a date after a week', () {
    expect(ago(const Duration(days: 10)), '1 Oct');
  });

  test('includes the year for another year', () {
    expect(TimeAgo.format(DateTime(2025, 12, 24), now: now), '24 Dec 2025');
  });
}
