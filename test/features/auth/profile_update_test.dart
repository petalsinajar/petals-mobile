import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/core/storage/token_storage.dart';
import 'package:petalsinajar/features/auth/data/auth_remote_source.dart';
import 'package:petalsinajar/features/auth/data/auth_repository_impl.dart';
import 'package:petalsinajar/features/auth/domain/me.dart';

import '../../helpers/fake_http_adapter.dart';

/// Profile reads and edits against JSON shaped like the API's MeResource.
void main() {
  late FakeHttpAdapter api;
  late AuthRepositoryImpl repo;
  late Map<String, dynamic> me;

  setUp(() {
    me = {
      'type': 'user',
      'id': 'u1',
      'handle': 'kwame.b',
      'display_name': 'Kwame Boateng',
      'avatar_url': null,
      'bio': null,
      'city': 'Accra',
      'is_private': false,
      'counts': {'followers': 12, 'following': 30, 'posts': 4},
      'phone': '+233241234567',
      'email': null,
      'settings': <String, dynamic>{},
      'is_admin': false,
      'needs_profile': false,
      'vendors': <Object>[],
    };
    api = FakeHttpAdapter((o) async {
      return switch ((o.method, o.path)) {
        ('GET', '/me') => jsonBody(200, me),
        ('PATCH', '/me') => () {
          // A copy: the recorded request must stay as sent.
          final body = Map<String, dynamic>.from(o.data as Map);
          if (body['handle'] == 'taken') {
            return jsonBody(422, {
              'message': 'That handle is already taken.',
              'errors': {
                'handle': ['That handle is already taken.'],
              },
            });
          }
          final settings = body.remove('settings') as Map?;
          me = {...me, ...body};
          if (settings != null) me['settings'] = settings;
          return jsonBody(200, me);
        }(),
        ('POST', '/uploads') => jsonBody(201, {
          'url': 'https://petalsinajar.com/storage/uploads/2026/11/me.jpg',
          'width': 800,
          'height': 800,
        }),
        ('PUT', '/me/dashboard-credentials')
            when (o.data as Map)['email'] == 'used@example.com' =>
          jsonBody(422, {
            'message': 'The email has already been taken.',
            'errors': {
              'email': ['The email has already been taken.'],
            },
          }),
        ('PUT', '/me/dashboard-credentials') => jsonBody(200, {
          'message': 'Dashboard sign-in saved.',
        }),
        _ => jsonBody(500, {'message': 'Unexpected ${o.method} ${o.path}'}),
      };
    });
    final dio = Dio(BaseOptions(baseUrl: 'https://api.test/v1'))
      ..httpClientAdapter = api;
    repo = AuthRepositoryImpl(
      source: AuthRemoteSource(dio),
      tokens: InMemoryTokenStorage(const AuthTokens(access: 'a', refresh: 'r')),
      deviceName: () async => 'test',
    );
  });

  test('reads the profile summary and settings', () async {
    final m = (await repo.restore())!;

    expect(m.city, 'Accra');
    expect(m.bio, isNull);
    expect(m.counts, const MeCounts(followers: 12, following: 30, posts: 4));
    expect(m.isPrivate, isFalse);
    expect(
      m.notify,
      const NotifySettings(),
      reason: 'unset settings are on, as the server reads them',
    );
  });

  test('saves only the fields that changed', () async {
    final m = await repo.updateMe(
      const ProfileChanges(bio: 'Event planner in Accra', city: 'Kumasi'),
    );

    final patch = api.requests.singleWhere((r) => r.method == 'PATCH');
    expect(patch.data, {'bio': 'Event planner in Accra', 'city': 'Kumasi'});
    expect(m.bio, 'Event planner in Accra');
    expect(m.city, 'Kumasi');
  });

  test('clearing a field sends null', () async {
    await repo.updateMe(const ProfileChanges(city: ''));

    final patch = api.requests.singleWhere((r) => r.method == 'PATCH');
    expect(patch.data, {'city': null});
  });

  test('notification switches patch settings.notify', () async {
    final m = await repo.updateMe(
      const ProfileChanges(notify: NotifySettings(sms: false)),
    );

    final patch = api.requests.singleWhere((r) => r.method == 'PATCH');
    expect(patch.data, {
      'settings': {
        'notify': {'push': true, 'sms': false, 'suggestions': true},
      },
    });
    expect(m.notify.sms, isFalse);
  });

  test('a new photo is uploaded first and its url returned', () async {
    final file = File(
      '${Directory.systemTemp.createTempSync().path}/me.jpg',
    )..writeAsBytesSync([0xFF, 0xD8, 0xFF]);

    final url = await repo.uploadPhoto(file.path);

    expect(url, 'https://petalsinajar.com/storage/uploads/2026/11/me.jpg');
    expect(api.requests.single.data, isA<FormData>());
  });

  test('a taken handle is a validation error on handle', () async {
    await expectLater(
      repo.updateMe(const ProfileChanges(handle: 'taken')),
      throwsA(
        isA<ApiException>().having(
          (e) => e.fieldError('handle'),
          'handle',
          'That handle is already taken.',
        ),
      ),
    );
  });

  test('web dashboard sign-in saves an email and password', () async {
    await repo.setDashboardSignIn(
      email: ' kwame@example.com ',
      password: 'chairs4ever2026',
    );

    final put = api.requests.singleWhere((r) => r.method == 'PUT');
    expect(put.path, '/me/dashboard-credentials');
    expect(put.data, {
      'email': 'kwame@example.com',
      'password': 'chairs4ever2026',
    });
  });

  test('an email already in use is a validation error on email', () async {
    await expectLater(
      repo.setDashboardSignIn(
        email: 'used@example.com',
        password: 'x1234567890',
      ),
      throwsA(
        isA<ApiException>().having(
          (e) => e.fieldError('email'),
          'email',
          isNotNull,
        ),
      ),
    );
  });
}
