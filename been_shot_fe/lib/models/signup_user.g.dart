// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SignupUser _$SignupUserFromJson(Map<String, dynamic> json) => _SignupUser(
  username: json['username'] as String,
  email: json['email'] as String,
  password: json['password'] as String,
);

Map<String, dynamic> _$SignupUserToJson(_SignupUser instance) =>
    <String, dynamic>{
      'username': instance.username,
      'email': instance.email,
      'password': instance.password,
    };
