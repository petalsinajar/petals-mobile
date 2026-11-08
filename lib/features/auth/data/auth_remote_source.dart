import 'package:dio/dio.dart';
import 'package:petalsinajar/core/mock/seed_loader.dart';
import 'package:petalsinajar/core/network/api_exception.dart';
import 'package:petalsinajar/features/auth/data/auth_source.dart';

class AuthRemoteSource implements AuthSource {
  AuthRemoteSource(this._dio);

  final Dio _dio;

  Future<Json> _call(Future<Response<Json>> Function() request) async {
    try {
      final response = await request();
      return response.data ?? const {};
    } on DioException catch (e) {
      throw ApiException.fromDioException(e);
    }
  }

  @override
  Future<Json> requestOtp(String phone) =>
      _call(() => _dio.post<Json>('/auth/otp', data: {'phone': phone}));

  @override
  Future<Json> verify({
    required String phone,
    required String code,
    required String deviceName,
  }) => _call(
    () => _dio.post<Json>(
      '/auth/verify',
      data: {'phone': phone, 'code': code, 'device_name': deviceName},
    ),
  );

  @override
  Future<Json> me() => _call(() => _dio.get<Json>('/me'));

  @override
  Future<Json> updateMe(Json fields) =>
      _call(() => _dio.patch<Json>('/me', data: fields));

  @override
  Future<Json> uploadImage(String path) async {
    final form = FormData.fromMap({'file': await MultipartFile.fromFile(path)});
    return _call(() => _dio.post<Json>('/uploads', data: form));
  }

  @override
  Future<Json> setDashboardCredentials(String email, String password) => _call(
    () => _dio.put<Json>(
      '/me/dashboard-credentials',
      data: {'email': email, 'password': password},
    ),
  );

  @override
  Future<Json> handleAvailable(String handle) => _call(
    () => _dio.get<Json>('/handles/${Uri.encodeComponent(handle)}/available'),
  );

  @override
  Future<void> logout() => _call(() => _dio.post<Json>('/auth/logout'));
}
