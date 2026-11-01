import '../models/login_user.dart';
import '../models/signup_user.dart';
import '../repositories/secure_storage.dart';
import '../services/dio.dart';

class AccountService {
  static const _protocol = String.fromEnvironment(
    'PROTOCOL',
    defaultValue: 'http',
  );
  static const _domain = String.fromEnvironment(
    'DOMAIN',
    defaultValue: 'localhost:8000',
  );
  static String baseUrl = '$_protocol://$_domain/api/auth';

  Future<void> login({required LoginUser loginUser}) async {
    final dioClient = DioClient();
    final url = '$baseUrl/token/';
    final response = await dioClient.unauthDio.post(
      url,
      data: loginUser.toJson(),
    );

    final accessToken = response.data['access'] as String;
    final refreshToken = response.data['refresh'] as String;
    final secureStorage = SecureStorage();
    await secureStorage.saveToken('access', accessToken);
    await secureStorage.saveToken('refresh', refreshToken);
  }

  Future<void> signup({required SignupUser signupUser}) async {
    final dioClient = DioClient();
    final url = '$baseUrl/users/';
    await dioClient.unauthDio.post(url, data: signupUser.toJson());
  }
}
