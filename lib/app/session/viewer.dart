import 'package:petalsinajar/features/auth/presentation/auth_session.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'viewer.g.dart';

/// The signed-in user's id, or null when signed out (or still restoring).
///
/// Lives in the app layer so features can ask "is someone signed in?"
/// without importing the auth feature's internals.
///
/// Listeners are only told when the id itself changes (a new value equal to
/// the old one doesn't notify), so profile edits don't reload feeds.
@Riverpod(keepAlive: true)
String? viewerId(Ref ref) => ref.watch(authSessionProvider).value?.id;
