import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../services/posts.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _PostsTestPageState();
}

class _PostsTestPageState extends State<HomePage> {
  String _result = 'まだ実行していません';
  bool _isLoading = false;

  Future<void> _checkFetchPosts() async {
    setState(() {
      _isLoading = true;
    });

    final postServices = PostsService();
    try {
      final response = await postServices.fetchPosts();
      setState(() {
        _result =
            '成功: ステータスコード=${response.statusCode}\n'
            'データ=${response.data}';
      });
    } on DioException catch (e) {
      setState(() {
        _result =
            'DioException: コード=${e.response?.statusCode}, '
            '内容=${e.response?.data}';
      });
    } catch (e) {
      setState(() {
        _result = 'その他のエラー: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(toolbarHeight: 5.0),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Center(
                child: SizedBox(
                  width: screenWidth * 0.9,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      elevation: 0,
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                    ),
                    onPressed: _isLoading ? null : _checkFetchPosts,
                    child: _isLoading
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(),
                          )
                        : const Text(
                            'fetchPosts を実行',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              flex: 2,
              child: SingleChildScrollView(child: Text(_result)),
            ),
          ],
        ),
      ),
    );
  }
}
