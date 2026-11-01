import 'package:dio/dio.dart';

import '../repositories/secure_storage.dart';

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
}
