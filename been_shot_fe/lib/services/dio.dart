import 'dart:io';

import 'package:dio/dio.dart';

import 'auth_interceptor.dart';

class DioClient {
  factory DioClient() => _instance;

  DioClient._createSingleton() {
    authDio = _createDio();
    authDio.interceptors.add(AuthInterceptor(authDio));
    unauthDio = _createDio();
  }

  static final DioClient _instance = DioClient._createSingleton();

  late final Dio authDio;
  late final Dio unauthDio;

  Dio _createDio() {
    return Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        headers: {HttpHeaders.contentTypeHeader: ContentType.json.value},
        validateStatus: (status) {
          return status != null && status < 400;
        },
      ),
    );
  }
}
