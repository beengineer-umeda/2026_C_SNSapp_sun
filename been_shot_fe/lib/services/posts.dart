import 'package:dio/dio.dart';

import 'dio.dart';

class PostsService {
  static const _protocol = String.fromEnvironment(
    'PROTOCOL',
    defaultValue: 'http',
  );
  static const _domain = String.fromEnvironment(
    'DOMAIN',
    defaultValue: 'localhost:8000',
  );

  static String baseUrl = '$_protocol://$_domain/api';
  final dioClient = DioClient().authDio;

  Future<Response> fetchPosts() async {
    final url = '$baseUrl/posts/';
    final response = await dioClient.get(url);
    return response;
  }
}
