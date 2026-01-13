// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locations_properties_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocationsPropertiesResponse _$LocationsPropertiesResponseFromJson(
  Map<String, dynamic> json,
) => LocationsPropertiesResponse(
  meta: json['meta'] == null
      ? null
      : LocationsPropertiesResponseMeta.fromJson(
          json['meta'] as Map<String, dynamic>,
        ),
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => (e as num).toInt())
      .toList(),
);

Map<String, dynamic> _$LocationsPropertiesResponseToJson(
  LocationsPropertiesResponse instance,
) => <String, dynamic>{'meta': instance.meta, 'data': instance.data};

LocationsPropertiesResponseMeta _$LocationsPropertiesResponseMetaFromJson(
  Map<String, dynamic> json,
) => LocationsPropertiesResponseMeta(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$LocationsPropertiesResponseMetaToJson(
  LocationsPropertiesResponseMeta instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
};
