import 'package:petalsinajar/app/config/app_config.dart';
import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/mock_session.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/network/dio_client.dart';
import 'package:petalsinajar/core/storage/token_storage.dart';
import 'package:petalsinajar/features/auth/data/auth_dtos.dart';
import 'package:petalsinajar/features/auth/data/auth_mock_source.dart';
import 'package:petalsinajar/features/auth/data/auth_remote_source.dart';
import 'package:petalsinajar/features/auth/data/auth_source.dart';
import 'package:petalsinajar/features/auth/data/device_name.dart';
import 'package:petalsinajar/features/auth/domain/auth_repository.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository_impl.g.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthSource source,
    required TokenStorage tokens,
    required Future<String> Function() deviceName,
  }) : _source = source,
       _tokens = tokens,
       _deviceName = deviceName;

  final AuthSource _source;
  final TokenStorage _tokens;
  final Future<String> Function() _deviceName;

  /// Malformed payloads surface as [ApiException]s, like network errors.
  Future<T> _parse<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on ApiException {
      rethrow;
    } on Object catch (e) {
      throw ApiException.from(e);
    }
  }

  @override
  Future<OtpChallenge> requestOtp(String phone) => _parse(() async {
    final body = await _source.requestOtp(phone);
    return OtpChallenge(
      phone: body['phone'] as String? ?? phone,
      expiresIn: Duration(
        seconds: (body['expires_in'] as num?)?.toInt() ?? 600,
      ),
    );
  });

  @override
  Future<Me> verify({required String phone, required String code}) =>
      _parse(() async {
        final body = await _source.verify(
          phone: phone,
          code: code,
          deviceName: await _deviceName(),
        );
        final me = MeDto.fromJson(body['user'] as Json).toDomain();
        await _tokens.write(
          AuthTokens(
            access: body['access_token'] as String,
            refresh: body['refresh_token'] as String,
          ),
        );
        return me;
      });

  @override
  Future<Me?> restore() => _parse(() async {
    if (await _tokens.read() == null) return null;
    try {
      return MeDto.fromJson(await _source.me()).toDomain();
    } on ApiException catch (e) {
      if (e.type != ApiErrorType.unauthorized) rethrow;
      await _tokens.clear();
      return null;
    }
  });

  @override
  Future<void> signOut() async {
    try {
      await _source.logout();
    } on Object {
      // Best effort: the server's tokens expire on their own.
    } finally {
      await _tokens.clear();
    }
  }
}

@Riverpod(keepAlive: true)
AuthRepository authRepository(Ref ref) {
  final source = ref.watch(appConfigProvider).useMocks
      ? AuthMockSource(
          seed: ref.watch(seedLoaderProvider),
          delay: ref.watch(mockDelayProvider),
          viewerId: ref.watch(mockViewerIdProvider),
        )
      : AuthRemoteSource(ref.watch(dioProvider));
  return AuthRepositoryImpl(
    source: source,
    tokens: ref.watch(tokenStorageProvider),
    deviceName: () => ref.read(deviceNameProvider.future),
  );
}
