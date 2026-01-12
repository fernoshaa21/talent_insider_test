// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'properties_search_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PropertiesSearchResponse _$PropertiesSearchResponseFromJson(
  Map<String, dynamic> json,
) => PropertiesSearchResponse(
  meta: json['meta'] == null
      ? null
      : MetaSearchProperties.fromJson(json['meta'] as Map<String, dynamic>),
  data: json['data'] == null
      ? null
      : PropertiesSearchData.fromJson(json['data'] as Map<String, dynamic>),
  pagination: json['pagination'] == null
      ? null
      : PaginationSearchProperties.fromJson(
          json['pagination'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$PropertiesSearchResponseToJson(
  PropertiesSearchResponse instance,
) => <String, dynamic>{
  'meta': instance.meta,
  'data': instance.data,
  'pagination': instance.pagination,
};

PropertiesSearchData _$PropertiesSearchDataFromJson(
  Map<String, dynamic> json,
) => PropertiesSearchData(
  data: (json['data'] as List<dynamic>?)
      ?.map((e) => PropertiesSearchDatum.fromJson(e as Map<String, dynamic>))
      .toList(),
  path: json['path'] as String?,
  perPage: (json['per_page'] as num?)?.toInt(),
  nextCursor: json['next_cursor'] as String?,
  nextPageUrl: json['next_page_url'] as String?,
  prevCursor: json['prev_cursor'] as String?,
  prevPageUrl: json['prev_page_url'] as String?,
);

Map<String, dynamic> _$PropertiesSearchDataToJson(
  PropertiesSearchData instance,
) => <String, dynamic>{
  'data': instance.data,
  'path': instance.path,
  'per_page': instance.perPage,
  'next_cursor': instance.nextCursor,
  'next_page_url': instance.nextPageUrl,
  'prev_cursor': instance.prevCursor,
  'prev_page_url': instance.prevPageUrl,
};

PropertiesSearchDatum _$PropertiesSearchDatumFromJson(
  Map<String, dynamic> json,
) => PropertiesSearchDatum(
  id: (json['id'] as num?)?.toInt(),
  name: json['name'] as String?,
  price: json['price'] as String?,
  type: $enumDecodeNullable(_$PropertyTypeSearchEnumMap, json['type']),
  imageUrl: json['image_url'] as String?,
  address: json['address'] as String?,
);

Map<String, dynamic> _$PropertiesSearchDatumToJson(
  PropertiesSearchDatum instance,
) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'price': instance.price,
  'type': _$PropertyTypeSearchEnumMap[instance.type],
  'image_url': instance.imageUrl,
  'address': instance.address,
};

const _$PropertyTypeSearchEnumMap = {PropertyTypeSearch.rumah: 'rumah'};

MetaSearchProperties _$MetaSearchPropertiesFromJson(
  Map<String, dynamic> json,
) => MetaSearchProperties(
  code: (json['code'] as num?)?.toInt(),
  status: json['status'] as String?,
  message: json['message'] as String?,
);

Map<String, dynamic> _$MetaSearchPropertiesToJson(
  MetaSearchProperties instance,
) => <String, dynamic>{
  'code': instance.code,
  'status': instance.status,
  'message': instance.message,
};

PaginationSearchProperties _$PaginationSearchPropertiesFromJson(
  Map<String, dynamic> json,
) => PaginationSearchProperties(
  perPage: (json['per_page'] as num?)?.toInt(),
  hasMorePages: json['has_more_pages'] as bool?,
  nextPageUrl: json['next_page_url'] as String?,
  prevPageUrl: json['prev_page_url'] as String?,
);

Map<String, dynamic> _$PaginationSearchPropertiesToJson(
  PaginationSearchProperties instance,
) => <String, dynamic>{
  'per_page': instance.perPage,
  'has_more_pages': instance.hasMorePages,
  'next_page_url': instance.nextPageUrl,
  'prev_page_url': instance.prevPageUrl,
};
