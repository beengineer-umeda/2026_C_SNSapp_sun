import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../components/post_tile.dart';
import '../providers/post_list.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(postListProvider);

    return Scaffold(
      appBar: AppBar(toolbarHeight: 5.0),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(postListProvider);
        },
        child: asyncPosts.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (err, _) => Center(child: Text('エラーが発生しました：$err')),
          data: (posts) {
            if (posts.isEmpty) {
              return ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 80),
                  Center(
                    child: Text('投稿がありません', style: TextStyle(fontSize: 18)),
                  ),
                ],
              );
            }

            return ListView.builder(
              physics: const AlwaysScrollableScrollPhysics(),
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return PostTile(post: post);
              },
            );
          },
        ),
      ),
    );
  }
}
