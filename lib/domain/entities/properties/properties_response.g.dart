// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertiesResponse _$PropertiesResponseFromJson(Map<String, dynamic> json) =>
    PropertiesResponse(
      meta: json['meta'] == null
          ? null
          : MetaGetProperties.fromJson(json['meta'] as Map<String, dynamic>),
      data: json['data'] == null
          ? null
          : PropertiesData.fromJson(json['data'] as Map<String, dynamic>),
      pagination: json['pagination'] == null
          ? null
          : PaginationGetProperties.fromJson(
              json['pagination'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$PropertiesResponseToJson(PropertiesResponse instance) =>
    <String, dynamic>{
      'meta': instance.meta,
      'data': instance.data,
      'pagination': instance.pagination,
    };

PropertiesData _$PropertiesDataFromJson(Map<String, dynamic> json) =>
    PropertiesData(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => PropertiesDatum.fromJson(e as Map<String, dynamic>))
          .toList(),
      path: json['path'] as String?,
      perPage: (json['per_page'] as num?)?.toInt(),
      nextCursor: json['next_cursor'] as String?,
      nextPageUrl: json['next_page_url'] as String?,
      prevCursor: json['prev_cursor'],
      prevPageUrl: json['prev_page_url'],
    );

Map<String, dynamic> _$PropertiesDataToJson(PropertiesData instance) =>
    <String, dynamic>{
      'data': instance.data,
      'path': instance.path,
      'per_page': instance.perPage,
      'next_cursor': instance.nextCursor,
      'next_page_url': instance.nextPageUrl,
      'prev_cursor': instance.prevCursor,
      'prev_page_url': instance.prevPageUrl,
    };

PropertiesDatum _$PropertiesDatumFromJson(Map<String, dynamic> json) =>
    PropertiesDatum(
      id: (json['id'] as num?)?.toInt(),
      name: json['name'] as String?,
      price: json['price'] as String?,
      type: $enumDecodeNullable(_$TypeEnumMap, json['type']),
      imageUrl: json['image_url'] as String?,
      address: json['address'] as String?,
    );

Map<String, dynamic> _$PropertiesDatumToJson(PropertiesDatum instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'type': _$TypeEnumMap[instance.type],
      'image_url': instance.imageUrl,
      'address': instance.address,
    };

const _$TypeEnumMap = {Type.RUMAH: 'rumah'};

MetaGetProperties _$MetaGetPropertiesFromJson(Map<String, dynamic> json) =>
    MetaGetProperties(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MetaGetPropertiesToJson(MetaGetProperties instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
    };

PaginationGetProperties _$PaginationGetPropertiesFromJson(
  Map<String, dynamic> json,
) => PaginationGetProperties(
  perPage: (json['per_page'] as num?)?.toInt(),
  hasMorePages: json['has_more_pages'] as bool?,
  nextPageUrl: json['next_page_url'] as String?,
  prevPageUrl: json['prev_page_url'],
);

Map<String, dynamic> _$PaginationGetPropertiesToJson(
  PaginationGetProperties instance,
) => <String, dynamic>{
  'per_page': instance.perPage,
  'has_more_pages': instance.hasMorePages,
  'next_page_url': instance.nextPageUrl,
  'prev_page_url': instance.prevPageUrl,
};
