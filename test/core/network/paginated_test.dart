import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/mock/mock_pagination.dart';
import 'package:petalsinajar/core/network/paginated.dart';

void main() {
  group('Paginated', () {
    test('parses the API envelope', () {
      final page = Paginated.fromJson(
        const {
          'data': [
            {'id': 'a'},
            {'id': 'b'},
          ],
          'next_cursor': 'c2',
        },
        (json) => json['id'] as String,
      );
      expect(page.items, ['a', 'b']);
      expect(page.nextCursor, 'c2');
      expect(page.hasMore, isTrue);
    });

    test('last page has no cursor', () {
      final page = Paginated.fromJson(
        const {'data': <dynamic>[], 'next_cursor': null},
        (json) => json,
      );
      expect(page.hasMore, isFalse);
      expect(page.isEmpty, isTrue);
    });

    test('append keeps order and takes the new cursor', () {
      const first = Paginated(items: [1, 2], nextCursor: '2');
      const second = Paginated(items: [3]);
      expect(first.append(second), const Paginated(items: [1, 2, 3]));
    });
  });

  group('paginateList', () {
    final all = List.generate(25, (i) => i);

    test('walks pages until the cursor is null', () {
      final p1 = paginateList(all);
      final p2 = paginateList(all, cursor: p1.nextCursor);
      final p3 = paginateList(all, cursor: p2.nextCursor);
      expect(p1.items, List.generate(10, (i) => i));
      expect(p2.items.first, 10);
      expect(p3.items, [20, 21, 22, 23, 24]);
      expect(p3.nextCursor, isNull);
    });

    test('a cursor past the end returns an empty last page', () {
      final page = paginateList(all, cursor: '99');
      expect(page.isEmpty, isTrue);
      expect(page.hasMore, isFalse);
    });
  });
}
