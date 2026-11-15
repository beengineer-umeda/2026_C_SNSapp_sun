import 'package:dio/dio.dart';

import '../repositories/secure_storage.dart';
import 'account.dart';

class AuthInterceptor extends QueuedInterceptor {
  AuthInterceptor(this.dio);

  final Dio dio;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    if (options.headers['Authorization']?.isEmpty ?? true) {
      final secureStorage = SecureStorage();
      final accessToken = await secureStorage.getToken('access');
      if (accessToken != null) {
        options.headers['Authorization'] = 'Bearer $accessToken';
      }
    }
    return handler.next(options);
  }

  @override
  Future<void> onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      final secureStorage = SecureStorage();
      final refreshToken = await secureStorage.getToken('refresh');
      if (refreshToken != null) {
        try {
          final accountService = AccountService();
          final newAccessToken = await accountService.refreshAccessToken(
            refreshToken,
          );
          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';
          final response = await dio.fetch(err.requestOptions);
          return handler.resolve(response);
        } catch (e) {
          return handler.next(err);
        }
      }
    }
    return handler.next(err);
  }
}
