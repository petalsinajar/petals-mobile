import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/storage/token_storage.dart';
import 'package:petalsinajar/features/auth/data/auth_mock_source.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/data/auth_source.dart';

class _MockSource extends Mock implements AuthSource {}

const _ama = '01KK67BN00FWWT9PCC060FWN3G';
const _signedIn = AuthTokens(access: 'a', refresh: 'r');

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late InMemoryTokenStorage tokens;

  setUp(() => tokens = InMemoryTokenStorage());

  group('over the mock source', () {
    late AuthRepositoryImpl repo;

    setUp(() {
      repo = AuthRepositoryImpl(
        source: AuthMockSource(
          seed: SeedLoader(),
          delay: MockDelay.none(),
          viewerId: _ama,
        ),
        tokens: tokens,
        deviceName: () async => 'test device',
      );
    });

    test('requesting a code normalises local numbers to +233', () async {
      final challenge = await repo.requestOtp('024 000 0001');

      expect(challenge.phone, '+233240000001');
      expect(challenge.expiresIn, const Duration(minutes: 10));
    });

    test('the dev code signs in, stores tokens and returns me', () async {
      final me = await repo.verify(phone: '+233240000001', code: '123456');

      expect(me.id, _ama);
      expect(me.displayName, 'Ama Mensah');
      expect(me.needsProfile, isFalse);
      expect(me.vendors.single.name, 'Royal Canopies & Chairs');
      expect(me.vendors.single.role, 'owner');
      expect(await tokens.read(), isNotNull);
    });

    test('a wrong code is a validation error on `code`', () async {
      await expectLater(
        repo.verify(phone: '+233240000001', code: '000000'),
        throwsA(
          isA<ApiException>()
              .having((e) => e.type, 'type', ApiErrorType.validation)
              .having((e) => e.fieldError('code'), 'code', isNotNull),
        ),
      );
      expect(await tokens.read(), isNull);
    });

    test('restore without tokens is signed out', () async {
      expect(await repo.restore(), isNull);
    });

    test('restore with tokens loads me', () async {
      await tokens.write(_signedIn);
      expect((await repo.restore())?.id, _ama);
    });
  });

  group('failure paths', () {
    late _MockSource source;
    late AuthRepositoryImpl repo;

    setUp(() {
      source = _MockSource();
      repo = AuthRepositoryImpl(
        source: source,
        tokens: tokens,
        deviceName: () async => 'Petalsinajar ios 1a2b3c4d',
      );
    });

    test('verify sends the device name the server signs out by', () async {
      when(
        () => source.verify(
          phone: any(named: 'phone'),
          code: any(named: 'code'),
          deviceName: any(named: 'deviceName'),
        ),
      ).thenAnswer(
        (_) async => {
          'access_token': 'a',
          'refresh_token': 'r',
          'is_new': true,
          'user': {
            'id': 'u1',
            'handle': 'user0001',
            'display_name': '',
            'phone': '+233240000001',
            'needs_profile': true,
            'vendors': <Object>[],
          },
        },
      );

      final me = await repo.verify(phone: '+233240000001', code: '1');

      verify(
        () => source.verify(
          phone: '+233240000001',
          code: '1',
          deviceName: 'Petalsinajar ios 1a2b3c4d',
        ),
      ).called(1);
      expect(me.needsProfile, isTrue);
      expect(await tokens.read(), _signedIn);
    });

    test('restore drops tokens the server no longer accepts', () async {
      await tokens.write(_signedIn);
      when(source.me).thenThrow(
        const ApiException(
          type: ApiErrorType.unauthorized,
          message: 'Unauthenticated.',
          statusCode: 401,
        ),
      );

      expect(await repo.restore(), isNull);
      expect(await tokens.read(), isNull);
    });

    test('restore keeps tokens when offline, and rethrows', () async {
      await tokens.write(_signedIn);
      when(source.me).thenThrow(
        const ApiException(type: ApiErrorType.network, message: 'offline'),
      );

      await expectLater(repo.restore(), throwsA(isA<ApiException>()));
      expect(await tokens.read(), _signedIn);
    });

    test('sign out clears tokens even if the server call fails', () async {
      await tokens.write(_signedIn);
      when(source.logout).thenThrow(
        const ApiException(type: ApiErrorType.network, message: 'offline'),
      );

      await repo.signOut();

      expect(await tokens.read(), isNull);
    });
  });
}
