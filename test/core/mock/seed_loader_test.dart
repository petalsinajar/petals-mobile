import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';

class _FakeBundle extends CachingAssetBundle {
  _FakeBundle(this.files);

  final Map<String, Object> files;
  int loads = 0;

  @override
  Future<ByteData> load(String key) async {
    loads++;
    final file = files[key];
    if (file == null) throw StateError('missing $key');
    return ByteData.sublistView(utf8.encode(jsonEncode(file)));
  }
}

void main() {
  final bundle = _FakeBundle({
    'assets/mock/bookings.json': {
      'generated_at': '2026-10-11T08:00:00Z',
      'data': [
        {
          'id': 'b1',
          'title': '2026-10-12',
          'starts_on': '2026-10-12',
          'created_at': '2026-10-11T06:20:00Z',
          'timeline': [
            {'status': 'pending_vendor', 'at': '2026-10-10T09:00:00Z'},
          ],
          'nested': {'hold_expires_at': '2026-10-13T08:00:00Z'},
          'respond_by_at': null,
        },
      ],
    },
  });

  test('shifts *_at and *_on by whole days since generated_at', () async {
    final loader = SeedLoader(
      bundle: bundle,
      clock: () => DateTime.utc(2026, 10, 14, 7), // 2 days 23 h later
    );
    final row = (await loader.load('bookings')).single;

    expect(row['starts_on'], '2026-10-14');
    expect(row['created_at'], '2026-10-13T06:20:00Z');
    expect((row['timeline'] as List).single, {
      'status': 'pending_vendor',
      'at': '2026-10-12T09:00:00Z',
    });
    expect(
      (row['nested'] as Map)['hold_expires_at'],
      '2026-10-15T08:00:00Z',
    );
    // Only date-ish keys move; nulls survive.
    expect(row['title'], '2026-10-12');
    expect(row['respond_by_at'], isNull);
  });

  test('no shift on the generation day, and results are cached', () async {
    final loader = SeedLoader(
      bundle: _FakeBundle(bundle.files),
      clock: () => DateTime.utc(2026, 10, 11, 20),
    );
    final first = await loader.load('bookings');
    final second = await loader.load('bookings');
    expect(first.single['starts_on'], '2026-10-12');
    expect(identical(first, second), isTrue);
  });
}
