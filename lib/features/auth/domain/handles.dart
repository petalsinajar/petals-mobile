/// The backend's `HandleRegistry` rules, so the app can suggest a handle
/// and reject bad ones before asking the server. The server still decides
/// whether one is taken.
library;

final _pattern = RegExp(r'^[a-z0-9](?:[a-z0-9._]{1,28}[a-z0-9])$');

const _reserved = {
  'admin', 'vendor', 'support', 'help', 'api', 'events', 'event', 'app', //
  'settings', 'me', 'login', 'signup', 'about', 'terms', 'privacy',
  'explore', 'discover',
};

/// `@Ama_Mensah ` → `ama_mensah`.
String normalizeHandle(String handle) {
  var h = handle.trim();
  while (h.startsWith('@')) {
    h = h.substring(1);
  }
  return h.toLowerCase();
}

/// Why [handle] can't be used, or null if it can (availability aside).
String? handleProblem(String handle) {
  final h = normalizeHandle(handle);
  if (!_pattern.hasMatch(h) || h.contains('..')) {
    return 'Use 3–30 letters, numbers, dots or underscores.';
  }
  if (_reserved.contains(h)) return 'That username is reserved.';
  return null;
}

/// A handle from a display name, as the backend suggests one:
/// "Ama Mensah" → `ama.mensah`.
String suggestHandle(String name) {
  var base = _ascii(name)
      .toLowerCase()
      .replaceAll(RegExp('[^a-z0-9]+'), '.')
      .replaceAll(RegExp(r'^\.+|\.+$'), '');
  if (base.length > 24) {
    base = base.substring(0, 24).replaceAll(RegExp(r'\.+$'), '');
  }
  return base.length >= 3 ? base : 'user$base';
}

/// Laravel's `Str::ascii` for the letters names here actually use:
/// combining marks dropped, accented Latin and Ghanaian letters folded.
String _ascii(String input) {
  final out = StringBuffer();
  for (final rune in input.runes) {
    if (rune >= 0x0300 && rune <= 0x036F) continue; // combining marks
    final char = String.fromCharCode(rune);
    out.write(_fold[char] ?? char);
  }
  return out.toString();
}

const _foldGroups = {
  'a': 'àáâãäåāăą',
  'A': 'ÀÁÂÃÄÅĀĂĄ',
  'c': 'çćč',
  'C': 'ÇĆČ',
  'e': 'èéêëēėęěẹɛ',
  'E': 'ÈÉÊËĒĖĘĚẸƐ',
  'i': 'ìíîïīįı',
  'I': 'ÌÍÎÏĪĮİ',
  'n': 'ñńňŋ',
  'N': 'ÑŃŇŊ',
  'o': 'òóôõöøōőọɔ',
  'O': 'ÒÓÔÕÖØŌŐỌƆ',
  's': 'śšş',
  'S': 'ŚŠŞ',
  'u': 'ùúûüūůűų',
  'U': 'ÙÚÛÜŪŮŰŲ',
  'y': 'ýÿ',
  'Y': 'ÝŸ',
  'z': 'źżž',
  'Z': 'ŹŻŽ',
};

final Map<String, String> _fold = {
  for (final MapEntry(key: plain, value: accented) in _foldGroups.entries)
    for (final c in accented.split('')) c: plain,
};
