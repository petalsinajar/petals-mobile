import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'mock_session.g.dart';

/// The seed user mock sources treat as signed in (Ama Mensah: hosts a
/// wedding, attends several events, owns a vendor).
///
/// Mock-only: with the real API the server knows who's calling. Signing in
/// with the mock auth source always signs in as this user, so the session's
/// `me` and the other mock sources agree.
@Riverpod(keepAlive: true)
String mockViewerId(Ref ref) => '01KK67BN00FWWT9PCC060FWN3G';
