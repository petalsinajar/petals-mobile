import 'package:petalsinajar/core/mock/mock_delay.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/auth/data/auth_source.dart';

/// Mirrors the backend's local environment: every number gets the code
/// [devCode] and no SMS is sent. Whatever number signs in, the session is
/// the seed viewer, because the other mock sources answer as them.
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

  Future<Json> _me() async {
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
    return {
      'token_type': 'Bearer',
      'access_token': 'mock-access',
      'refresh_token': 'mock-refresh',
      'is_new': false,
      'user': await _me(),
    };
  }

  @override
  Future<Json> me() async {
    await _delay();
    return _me();
  }

  @override
  Future<void> logout() => _delay();
}
