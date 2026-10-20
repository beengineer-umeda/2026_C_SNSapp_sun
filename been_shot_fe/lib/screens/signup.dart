import 'dart:core';

import 'package:dio/dio.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../models/signup_user.dart';
import '../routes.dart';
import '../services/account.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  Future<void> handleSubmit(
    BuildContext context, {
    required SignupUser formData,
  }) async {
    setState(() {
      _isLoading = true;
      _invalidUsernameError = null;
      _invalidEmailError = null;
      _invalidPasswordError = null;
    });
    try {
      final accountService = AccountService();
      await accountService.signup(signupUser: formData);
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('アカウントが作成されました')));
      await GoRouter.of(context).replace(Routes.login);
    } on DioException catch (e) {
      final statusCode = e.response?.statusCode;
      final data = e.response?.data;
      if (statusCode == 400 && data is Map<String, dynamic>) {
        final errors = data;
        setState(() {
          _invalidUsernameError = (errors['username'] as List?)?.first;
          _invalidEmailError = (errors['email'] as List?)?.first;
          _invalidPasswordError = (errors['password'] as List?)?.first;
        });
        if (!context.mounted) return;
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('会員登録に失敗しました')));
      }
    } catch (_) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('予期せぬエラーが発生しました')));
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  bool _isObscure = true;
  bool _isLoading = false;
  String? _invalidUsernameError;
  String? _invalidEmailError;
  String? _invalidPasswordError;
  final _formKey = GlobalKey<FormState>();
  final _usernameKey = GlobalKey<FormFieldState>();
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(title: const Text('会員登録')),
      body: Center(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.only(top: 50, right: 20, left: 20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      const Padding(padding: EdgeInsets.only(bottom: 30)),
                      TextFormField(
                        key: _usernameKey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: 'ユーザー名',
                          errorText: _invalidUsernameError,
                        ),
                        validator: (value) {
                          setState(() {
                            _invalidUsernameError = null;
                          });
                          if (value == null || value.isEmpty) {
                            return 'ユーザー名を入力してください';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        key: _emailKey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: 'メールアドレス',
                          errorText: _invalidEmailError,
                        ),
                        validator: (value) {
                          setState(() {
                            _invalidEmailError = null;
                          });
                          if (value == null || value.isEmpty) {
                            return 'メールアドレスを入力してください';
                          }
                          if (!EmailValidator.validate(value)) {
                            return '有効なメールアドレスを入力してください';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 20),
                      TextFormField(
                        key: _passwordKey,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                          labelText: 'パスワード',
                          errorText: _invalidPasswordError,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isObscure
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                            onPressed: () {
                              setState(() {
                                _isObscure = !_isObscure;
                              });
                            },
                          ),
                        ),
                        obscureText: _isObscure,
                        validator: (value) {
                          setState(() {
                            _invalidPasswordError = null;
                          });
                          if (value == null || value.isEmpty) {
                            return 'パスワードを入力してください';
                          }
                          if (value.length < 6) {
                            return 'パスワードは6文字以上で設定してください';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: TextButton(
                          onPressed: () {
                            context.go(Routes.login);
                          },
                          child: const Text('ログインする'),
                        ),
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
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
                          onPressed: _isLoading
                              ? null
                              : () {
                                  if (_formKey.currentState?.validate() ??
                                      false) {
                                    final formData = SignupUser(
                                      username:
                                          _usernameKey.currentState?.value,
                                      email: _emailKey.currentState?.value,
                                      password:
                                          _passwordKey.currentState?.value,
                                    );
                                    handleSubmit(context, formData: formData);
                                  }
                                },
                          child: _isLoading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(),
                                )
                              : Text(
                                  '会員登録',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
