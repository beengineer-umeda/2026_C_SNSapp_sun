import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'signup_user.freezed.dart';
part 'signup_user.g.dart';

@freezed
abstract class SignupUser with _$SignupUser {
  const factory SignupUser({
    required String username,
    required String email,
    required String password,
  }) = _SignupUser;

  factory SignupUser.fromJson(Map<String, Object?> json) =>
      _$SignupUserFromJson(json);
}
