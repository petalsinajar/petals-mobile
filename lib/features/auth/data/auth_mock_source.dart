import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/auth/data/auth_source.dart';
import 'package:petalsinajar/features/auth/domain/handles.dart';

/// Mirrors the backend's local environment: every number gets the code
/// [devCode] and no SMS is sent.
///
/// The seed viewer's number signs in as them. Any other number is a brand
/// new account with no name yet, to try the welcome step. It keeps the seed
/// viewer's id, because the other mock sources answer as them. Profile edits
/// live in memory until restart.
class AuthMockSource implements AuthSource {
  AuthMockSource({
    required SeedLoader seed,
    required MockDelay delay,
    required String viewerId,
  }) : _seed = seed,
       _delay = delay,
       _viewerId = viewerId;

  static const devCode = '123456';

  final SeedLoader _seed;
  final MockDelay _delay;
  final String _viewerId;

  /// The signed-in account, once someone signs in or edits their profile.
  /// Until then `me` is the seed viewer.
  Json? _account;

  /// The backend's `PhoneNumber::normalize`, defaulting to Ghana.
  static String? normalize(String input) {
    var digits = input.replaceAll(RegExp(r'[^\d+]'), '');
    if (digits.startsWith('00')) digits = '+${digits.substring(2)}';
    if (digits.startsWith('0')) digits = '+233${digits.substring(1)}';
    if (!digits.startsWith('+')) digits = '+$digits';
    return RegExp(r'^\+[1-9]\d{7,14}$').hasMatch(digits) ? digits : null;
  }

  static ApiException _invalid(String field, String message) => ApiException(
    type: ApiErrorType.validation,
    message: message,
    statusCode: 422,
    fieldErrors: {
      field: [message],
    },
  );

  Future<Json> _viewer() async {
    final [users, vendors] = await Future.wait([
      _seed.load('users'),
      _seed.load('vendors'),
    ]);
    final u = users.firstWhere((u) => u['id'] == _viewerId);
    return {
      'id': u['id'],
      'handle': u['handle'],
      'display_name': u['name'],
      'phone': u['phone'],
      'avatar_url': (u['avatar'] as Json?)?['url'],
      'needs_profile': false,
      'vendors': [
        for (final v in vendors)
          for (final m in (v['members'] as List).cast<Json>())
            if (m['user_id'] == _viewerId)
              {
                'id': v['id'],
                'handle': v['handle'],
                'name': v['name'],
                'logo_url': (v['logo'] as Json?)?['url'],
                'role': m['role'],
              },
      ],
    };
  }

  /// Like the backend's first sign-in: no name, a placeholder handle.
  Json _newAccount(String phone) => {
    'id': _viewerId,
    'handle': 'user${phone.substring(phone.length - 4)}',
    'display_name': '',
    'phone': phone,
    'avatar_url': null,
    'needs_profile': true,
    'vendors': <Json>[],
  };

  Future<Json> _me() async => _account ?? await _viewer();

  /// Every handle in the seed, users and vendors share one namespace.
  Future<Set<String>> _takenHandles() async {
    final [users, vendors] = await Future.wait([
      _seed.load('users'),
      _seed.load('vendors'),
    ]);
    return {
      for (final row in [...users, ...vendors]) row['handle'] as String,
      if (_account case {'handle': final String own}) own,
    };
  }

  @override
  Future<Json> requestOtp(String phone) async {
    await _delay();
    final normalized = normalize(phone);
    if (normalized == null) {
      throw _invalid('phone', 'Enter a valid phone number.');
    }
    return {'message': 'Code sent.', 'phone': normalized, 'expires_in': 600};
  }

  @override
  Future<Json> verify({
    required String phone,
    required String code,
    required String deviceName,
  }) async {
    await _delay();
    if (code != devCode) throw _invalid('code', 'That code is not correct.');
    final viewer = await _viewer();
    final isNew = phone != viewer['phone'];
    _account = isNew ? _newAccount(phone) : null;
    return {
      'token_type': 'Bearer',
      'access_token': 'mock-access',
      'refresh_token': 'mock-refresh',
      'is_new': isNew,
      'user': await _me(),
    };
  }

  @override
  Future<Json> me() async {
    await _delay();
    return _me();
  }

  @override
  Future<Json> updateMe(Json fields) async {
    await _delay();
    final account = {...await _me()};

    if (fields['display_name'] case final String name) {
      if (name.trim().isEmpty) {
        throw _invalid('display_name', 'The display name field is required.');
      }
      account['display_name'] = name.trim();
    }
    if (fields['handle'] case final String raw) {
      final handle = normalizeHandle(raw);
      if (handle != account['handle']) {
        if (handleProblem(handle) case final problem?) {
          throw _invalid('handle', problem);
        }
        if ((await _takenHandles()).contains(handle)) {
          throw _invalid('handle', 'That handle is already taken.');
        }
        account['handle'] = handle;
      }
    }
    for (final key in ['bio', 'city', 'avatar_url', 'is_private', 'settings']) {
      if (fields.containsKey(key)) account[key] = fields[key];
    }
    account['needs_profile'] = (account['display_name'] as String).isEmpty;
    return _account = account;
  }

  @override
  Future<Json> setDashboardCredentials(String email, String password) async {
    await _delay();
    _account?['email'] = email;
    _account?['has_dashboard_sign_in'] = true;
    return {'message': 'Dashboard sign-in saved.'};
  }

  @override
  Future<Json> handleAvailable(String handle) async {
    await _delay();
    final h = normalizeHandle(handle);
    final taken = await _takenHandles();
    return {
      'handle': h,
      'available': handleProblem(h) == null && !taken.contains(h),
    };
  }

  @override
  Future<void> logout() async {
    await _delay();
    _account = null;
  }
}
