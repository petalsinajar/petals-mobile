import 'package:petalsinajar/core/network/paginated.dart';

/// Cursor-paginates an in-memory list the way the API does. The cursor is an
/// opaque string to callers (here it encodes the offset).
Paginated<T> paginateList<T>(
  List<T> all, {
  String? cursor,
  int limit = 10,
}) {
  final start = cursor == null ? 0 : int.tryParse(cursor) ?? 0;
  final end = (start + limit).clamp(0, all.length);
  return Paginated(
    items: start >= all.length ? const [] : all.sublist(start, end),
    nextCursor: end < all.length ? '$end' : null,
  );
}
