import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';

/// One page of a cursor-paginated list:
/// `{ "data": [...], "next_cursor": "..." | null }`.
@immutable
class Paginated<T> {
  const Paginated({required this.items, this.nextCursor});

  const Paginated.empty() : items = const [], nextCursor = null;

  factory Paginated.fromJson(
    Map<String, dynamic> json,
    T Function(Map<String, dynamic> json) fromJsonT,
  ) {
    final data = (json['data'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>();
    return Paginated(
      items: data.map(fromJsonT).toList(growable: false),
      nextCursor: json['next_cursor'] as String?,
    );
  }

  final List<T> items;
  final String? nextCursor;

  bool get hasMore => nextCursor != null;
  bool get isEmpty => items.isEmpty;

  /// Appends the next page (infinite scroll).
  Paginated<T> append(Paginated<T> next) =>
      Paginated(items: [...items, ...next.items], nextCursor: next.nextCursor);

  Paginated<R> map<R>(R Function(T item) convert) => Paginated(
    items: items.map(convert).toList(growable: false),
    nextCursor: nextCursor,
  );

  @override
  bool operator ==(Object other) =>
      other is Paginated<T> &&
      other.nextCursor == nextCursor &&
      const ListEquality<Object?>().equals(other.items, items);

  @override
  int get hashCode =>
      Object.hash(nextCursor, const ListEquality<Object?>().hash(items));

  @override
  String toString() =>
      'Paginated(${items.length} items, nextCursor: $nextCursor)';
}
