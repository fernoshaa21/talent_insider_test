// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalUser _$LocalUserFromJson(Map<String, dynamic> json) => LocalUser(
  user: json['user'] == null
      ? null
      : User.fromJson(json['user'] as Map<String, dynamic>),
  accessToken: json['access_token'] as String?,
  tokenType: json['token_type'] as String?,
);

Map<String, dynamic> _$LocalUserToJson(LocalUser instance) => <String, dynamic>{
  'user': instance.user,
  'access_token': instance.accessToken,
  'token_type': instance.tokenType,
};

User _$UserFromJson(Map<String, dynamic> json) => User(
  id: (json['id'] as num?)?.toInt(),
  firstName: json['first_name'] as String?,
  lastName: json['last_name'] as String?,
  phone: json['phone'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  emailVerifiedAt: json['email_verified_at'],
  createdAt: json['created_at'] == null
      ? null
      : DateTime.parse(json['created_at'] as String),
  updatedAt: json['updated_at'] == null
      ? null
      : DateTime.parse(json['updated_at'] as String),
);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
  'id': instance.id,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'phone': instance.phone,
  'name': instance.name,
  'email': instance.email,
  'email_verified_at': instance.emailVerifiedAt,
  'created_at': instance.createdAt?.toIso8601String(),
  'updated_at': instance.updatedAt?.toIso8601String(),
};

Meta _$MetaFromJson(Map<String, dynamic> json) => Meta(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$MetaToJson(Meta instance) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
};
