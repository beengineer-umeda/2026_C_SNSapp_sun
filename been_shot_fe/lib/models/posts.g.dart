// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'posts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PostUser _$PostUserFromJson(Map<String, dynamic> json) => _PostUser(
  id: (json['id'] as num).toInt(),
  username: json['username'] as String,
  icon: json['icon'] as String?,
);

Map<String, dynamic> _$PostUserToJson(_PostUser instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'icon': instance.icon,
};

_Post _$PostFromJson(Map<String, dynamic> json) => _Post(
  id: (json['id'] as num).toInt(),
  user: PostUser.fromJson(json['user'] as Map<String, dynamic>),
  content: json['content'] as String,
  photo: json['photo'] as String?,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$PostToJson(_Post instance) => <String, dynamic>{
  'id': instance.id,
  'user': instance.user,
  'content': instance.content,
  'photo': instance.photo,
  'created_at': instance.createdAt,
};
