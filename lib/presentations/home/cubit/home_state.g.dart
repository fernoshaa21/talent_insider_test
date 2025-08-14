// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_HomeState _$HomeStateFromJson(Map<String, dynamic> json) => _HomeState(
  username: json['username'] as String?,
  time: json['time'] as String?,
  location: json['location'] as String?,
  status: json['status'] as String?,
  selfiePath: json['selfiePath'] as String?,
);

Map<String, dynamic> _$HomeStateToJson(_HomeState instance) =>
    <String, dynamic>{
      'username': instance.username,
      'time': instance.time,
      'location': instance.location,
      'status': instance.status,
      'selfiePath': instance.selfiePath,
    };
