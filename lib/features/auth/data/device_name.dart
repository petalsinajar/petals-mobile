import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:uuid/uuid.dart';

part 'device_name.g.dart';

/// The `device_name` sent when signing in, e.g. `Petalsinajar ios 1a2b3c4d`.
///
/// The server names this device's tokens after it and signs out by name, so
/// it must be unique per install: two phones both called "ios" would sign
/// each other out. The random part is created once and kept.
@Riverpod(keepAlive: true)
Future<String> deviceName(Ref ref) async {
  const storage = FlutterSecureStorage();
  const key = 'device_install_id';
  var id = await storage.read(key: key);
  if (id == null) {
    id = const Uuid().v4();
    await storage.write(key: key, value: id);
  }
  return 'Petalsinajar ${defaultTargetPlatform.name} ${id.substring(0, 8)}';
}
