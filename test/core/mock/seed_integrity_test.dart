import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';

/// Guards the hand-made seed in assets/mock against broken references,
/// so mock screens never crash on a dangling id.
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final ulid = RegExp(r'^[0-9A-HJKMNP-TV-Z]{26}$');
  final objectId = RegExp(r'^[0-9a-f]{24}$');

  late Map<String, List<Json>> seed;

  setUpAll(() async {
    final loader = SeedLoader();
    seed = {
      for (final name in [
        'users',
        'vendors',
        'categories',
        'items',
        'packages',
        'events',
        'posts',
        'bookings',
      ])
        name: await loader.load(name),
    };
  });

  Set<String> ids(String name) => {
    for (final row in seed[name]!) row['id'] as String,
  };

  void expectMedia(Object? media) {
    final m = media! as Json;
    expect(m['url'], startsWith('https://'));
    expect((m['blurhash'] as String).length, greaterThanOrEqualTo(6));
    expect(m['width'], isA<int>());
    expect(m['height'], isA<int>());
  }

  test('has the expected volume', () {
    expect(seed['users'], hasLength(8));
    expect(seed['vendors'], hasLength(6));
    expect(seed['items'], hasLength(40));
    expect(seed['packages'], hasLength(5));
    expect(seed['events'], hasLength(10));
    expect(seed['posts'], hasLength(30));
    expect(seed['bookings'], hasLength(greaterThanOrEqualTo(3)));
  });

  test('ids mirror the backend: ULIDs in SQL, ObjectIds in Mongo', () {
    for (final name in ['users', 'vendors', 'events', 'posts', 'bookings']) {
      for (final id in ids(name)) {
        expect(id, matches(ulid), reason: '$name $id');
      }
    }
    for (final item in seed['items']!) {
      expect(item['id'], matches(objectId));
      for (final v in item['variants'] as List) {
        expect((v as Json)['id'], matches(objectId));
      }
    }
  });

  test('covers all three event types', () {
    final types = seed['events']!.map((e) => e['type']).toSet();
    expect(types, {'wedding', 'birthday', 'corporate'});
  });

  test('one user owns a vendor, for testing vendor mode', () {
    final userIds = ids('users');
    final owners = [
      for (final v in seed['vendors']!)
        for (final m in v['members'] as List)
          if ((m as Json)['role'] == 'owner') m['user_id'],
    ];
    expect(owners, isNotEmpty);
    expect(owners.every(userIds.contains), isTrue);
  });

  test('items reference vendors and categories; money is integer GHS', () {
    final vendors = ids('vendors');
    final categories = ids('categories');
    for (final item in seed['items']!) {
      expect(vendors, contains(item['vendor_id']));
      expect(categories, contains(item['category_id']));
      expect(item['currency'], 'GHS');
      for (final tier in item['price_tiers'] as List) {
        expect((tier as Json)['amount_minor'], isA<int>());
      }
      (item['media'] as List).forEach(expectMedia);
    }
  });

  test('post tags point at real items, vendors and users', () {
    final targets = {
      'item': ids('items'),
      'vendor': ids('vendors'),
      'user': ids('users'),
    };
    final events = ids('events');
    var tagCount = 0;
    for (final post in seed['posts']!) {
      final author = post['author'] as Json;
      expect(targets[author['type']], contains(author['id']));
      if (post['event_id'] != null) expect(events, contains(post['event_id']));
      for (final media in post['media'] as List) {
        expectMedia(media);
        for (final tag in (media as Json)['tags'] as List) {
          final target = (tag as Json)['target'] as Json;
          expect(targets[target['type']], contains(target['id']));
          expect(tag['x'], inInclusiveRange(0, 1));
          expect(tag['y'], inInclusiveRange(0, 1));
          tagCount++;
        }
      }
    }
    expect(tagCount, greaterThan(30));
  });

  test("package and booking lines use the vendor's own variants", () {
    final variantsByVendor = <String, Set<String>>{};
    for (final item in seed['items']!) {
      variantsByVendor
          .putIfAbsent(item['vendor_id'] as String, () => {})
          .addAll([
            for (final v in item['variants'] as List)
              (v as Json)['id'] as String,
          ]);
    }
    for (final row in [...seed['packages']!, ...seed['bookings']!]) {
      final own = variantsByVendor[row['vendor_id']]!;
      final lines = (row['items'] ?? row['lines'])! as List;
      for (final line in lines) {
        expect(own, contains((line as Json)['variant_id']));
      }
    }
  });

  test('booking totals add up', () {
    for (final b in seed['bookings']!) {
      final lines = (b['lines'] as List).cast<Json>();
      final subtotal = lines.fold<int>(
        0,
        (sum, l) => sum + (l['line_total_minor'] as int),
      );
      expect(b['subtotal_minor'], subtotal);
      expect(
        b['total_minor'],
        (b['subtotal_minor'] as int) + (b['delivery_fee_minor'] as int),
      );
    }
  });
}
