import 'dart:convert';

import 'package:petalsinajar/core/storage/preferences.dart';
import 'package:petalsinajar/features/cart/domain/cart_line.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cart_controller.g.dart';

/// The host's carts, one per event, kept on the phone across launches.
@Riverpod(keepAlive: true)
class Cart extends _$Cart {
  static const storageKey = 'cart.lines';

  @override
  List<CartLine> build() {
    final raw = ref.read(sharedPreferencesProvider).getString(storageKey);
    if (raw == null) return const [];
    try {
      return [
        for (final j in (jsonDecode(raw) as List).cast<Map<String, dynamic>>())
          CartLine.fromJson(j),
      ];
    } on Object {
      return const []; // an older or corrupt cart isn't worth crashing over
    }
  }

  Future<void> _save(List<CartLine> lines) async {
    state = lines;
    await ref
        .read(sharedPreferencesProvider)
        .setString(storageKey, jsonEncode([for (final l in lines) l.toJson()]));
  }

  List<CartLine> forEvent(String eventId) =>
      state.where((l) => l.eventId == eventId).toList();

  /// Adds [line]; adding the same thing to the same event again bumps its
  /// quantity instead of duplicating it.
  Future<void> add(CartLine line) {
    bool same(CartLine l) =>
        l.eventId == line.eventId &&
        l.kind == line.kind &&
        l.refId == line.refId;
    final existing = state.where(same).firstOrNull;
    return _save([
      for (final l in state)
        if (same(l)) l.copyWith(quantity: l.quantity + line.quantity) else l,
      if (existing == null) line,
    ]);
  }

  Future<void> remove(CartLine line) => _save([
    for (final l in state)
      if (l != line) l,
  ]);
}
