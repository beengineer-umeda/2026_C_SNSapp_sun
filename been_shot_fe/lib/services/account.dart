import '../models/login_user.dart';
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
    await dioClient.unauthDio.post(url, data: loginUser.toJson());
  }
}
