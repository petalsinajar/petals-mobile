import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:petalsinajar/app/config/app_assets.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'seed_loader.g.dart';

typedef Json = Map<String, dynamic>;

/// Loads `assets/mock/<name>.json` (`{ "generated_at": ..., "data": [...] }`)
/// and caches the decoded rows.
///
/// Seed dates are written relative to `generated_at`. On load, every
/// `*_at` / `at` timestamp and `*_on` date is shifted by the whole days elapsed
/// since then, so "the delivery is tomorrow" stays true whenever you run it.
class SeedLoader {
  SeedLoader({AssetBundle? bundle, DateTime Function()? clock})
    : _bundle = bundle ?? rootBundle,
      _clock = clock ?? DateTime.now;

  final AssetBundle _bundle;
  final DateTime Function() _clock;
  final _cache = <String, Future<List<Json>>>{};

  Future<List<Json>> load(String name) =>
      _cache.putIfAbsent(name, () => _load(name));

  Future<List<Json>> _load(String name) async {
    final raw = await _bundle.loadString(AppAssets.mockSeed(name));
    final file = jsonDecode(raw) as Json;
    final rows = (file['data'] as List<dynamic>).cast<Json>();
    final generatedAt = DateTime.tryParse(
      file['generated_at'] as String? ?? '',
    );
    if (generatedAt == null) return rows;

    final shift = Duration(
      days: _clock().toUtc().difference(generatedAt).inDays,
    );
    if (shift == Duration.zero) return rows;
    return [for (final row in rows) _shift(row, shift)! as Json];
  }

  static Object? _shift(Object? value, Duration shift, [String? key]) {
    return switch (value) {
      final Map<String, dynamic> map => {
        for (final MapEntry(:key, :value) in map.entries)
          key: _shift(value, shift, key),
      },
      final List<dynamic> list => [for (final v in list) _shift(v, shift)],
      final String s when key != null && _isTimestampKey(key) =>
        _shiftTimestamp(
          s,
          shift,
        ),
      final String s when key != null && key.endsWith('_on') => _shiftDate(
        s,
        shift,
      ),
      _ => value,
    };
  }

  /// `starts_at`, `created_at`… and bare `at` (timeline entries).
  static bool _isTimestampKey(String key) => key == 'at' || key.endsWith('_at');

  static String _shiftTimestamp(String value, Duration shift) {
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    return parsed
        .toUtc()
        .add(shift)
        .toIso8601String()
        .replaceFirst(
          RegExp(r'\.\d+Z$'),
          'Z',
        );
  }

  static String _shiftDate(String value, Duration shift) {
    final parsed = DateTime.tryParse(value);
    if (parsed == null) return value;
    final shifted = DateTime.utc(
      parsed.year,
      parsed.month,
      parsed.day,
    ).add(shift);
    return shifted.toIso8601String().substring(0, 10);
  }
}

@Riverpod(keepAlive: true)
SeedLoader seedLoader(Ref ref) => SeedLoader();
