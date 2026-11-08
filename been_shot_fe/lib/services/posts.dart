import 'package:dio/dio.dart';
import '../models/posts.dart';

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

  Future<List<Post>> fetchPosts() async {
    final url = '$baseUrl/posts/';
    final response = await dioClient.get(url);
    final jsonList = response.data as List<dynamic>;
    return jsonList
        .map((jsonItem) => Post.fromJson(jsonItem as Map<String, dynamic>))
        .toList();
  }
}
