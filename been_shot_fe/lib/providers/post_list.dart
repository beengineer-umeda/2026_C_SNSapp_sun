import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/posts.dart';
import '../services/posts.dart';

part 'post_list.g.dart';

@riverpod
class PostList extends _$PostList {
  final postServices = PostsService();
  @override
  Future<List<Post>> build() async {
    try {
      final response = await postServices.fetchPosts();
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
