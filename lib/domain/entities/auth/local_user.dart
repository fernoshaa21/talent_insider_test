// To parse this JSON data, do
//
//     final localUser = localUserFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'local_user.g.dart';

@JsonSerializable()
class LocalUser {
  @JsonKey(name: "user")
  User? user;
  @JsonKey(name: "access_token")
  String? accessToken;
  @JsonKey(name: "token_type")
  String? tokenType;

  LocalUser({this.user, this.accessToken, this.tokenType});

  factory LocalUser.fromJson(Map<String, dynamic> json) =>
      _$LocalUserFromJson(json);

  Map<String, dynamic> toJson() => _$LocalUserToJson(this);
}

@JsonSerializable()
class User {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "first_name")
  String? firstName;
  @JsonKey(name: "last_name")
  String? lastName;
  @JsonKey(name: "phone")
  String? phone;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "email")
  String? email;
  @JsonKey(name: "email_verified_at")
  dynamic emailVerifiedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.phone,
    this.name,
    this.email,
    this.emailVerifiedAt,
    this.createdAt,
    this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);
}

@JsonSerializable()
class Meta {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;

  Meta({this.code, this.status, this.message});

  factory Meta.fromJson(Map<String, dynamic> json) => _$MetaFromJson(json);

  Map<String, dynamic> toJson() => _$MetaToJson(this);
}
