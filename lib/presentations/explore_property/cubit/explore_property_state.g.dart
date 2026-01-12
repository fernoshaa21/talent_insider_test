// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'explore_property_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ExplorePropertyState _$ExplorePropertyStateFromJson(
  Map<String, dynamic> json,
) => _ExplorePropertyState(
  status:
      $enumDecodeNullable(_$ExplorePropertyStatusEnumMap, json['status']) ??
      ExplorePropertyStatus.initial,
  properties: json['properties'] == null
      ? null
      : PropertiesResponse.fromJson(json['properties'] as Map<String, dynamic>),
  searchProperties: json['searchProperties'] == null
      ? null
      : PropertiesSearchResponse.fromJson(
          json['searchProperties'] as Map<String, dynamic>,
        ),
  errorMessage: json['errorMessage'] as String?,
);

Map<String, dynamic> _$ExplorePropertyStateToJson(
  _ExplorePropertyState instance,
) => <String, dynamic>{
  'status': _$ExplorePropertyStatusEnumMap[instance.status]!,
  'properties': instance.properties,
  'searchProperties': instance.searchProperties,
  'errorMessage': instance.errorMessage,
};

const _$ExplorePropertyStatusEnumMap = {
  ExplorePropertyStatus.initial: 'initial',
  ExplorePropertyStatus.loading: 'loading',
  ExplorePropertyStatus.success: 'success',
  ExplorePropertyStatus.unauthenticated: 'unauthenticated',
  ExplorePropertyStatus.failure: 'failure',
};
