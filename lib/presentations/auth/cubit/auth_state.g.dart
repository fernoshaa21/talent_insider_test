// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthState _$AuthStateFromJson(Map<String, dynamic> json) => _AuthState(
  status:
      $enumDecodeNullable(_$AuthStatusEnumMap, json['status']) ??
      AuthStatus.initial,
  user: json['user'] == null
      ? null
      : LocalUser.fromJson(json['user'] as Map<String, dynamic>),
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$AuthStateToJson(_AuthState instance) =>
    <String, dynamic>{
      'status': _$AuthStatusEnumMap[instance.status]!,
      'user': instance.user,
      'errorMessage': instance.errorMessage,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.initial: 'initial',
  AuthStatus.loading: 'loading',
  AuthStatus.authenticated: 'authenticated',
  AuthStatus.unauthenticated: 'unauthenticated',
  AuthStatus.failure: 'failure',
};
