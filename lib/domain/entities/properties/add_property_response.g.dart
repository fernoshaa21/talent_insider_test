// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_property_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AddPropertyResponse _$AddPropertyResponseFromJson(Map<String, dynamic> json) =>
    AddPropertyResponse(
      type: json['type'] as String?,
      status: json['status'] as String?,
      name: json['name'] as String?,
      description: json['description'] as String?,
      address: json['address'] as String?,
      price: json['price'] as String?,
      buildingArea: (json['building_area'] as num?)?.toInt(),
      landArea: (json['land_area'] as num?)?.toInt(),
      updatedAt: json['updated_at'] == null
          ? null
          : DateTime.parse(json['updated_at'] as String),
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
      id: (json['id'] as num?)?.toInt(),
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$AddPropertyResponseToJson(
  AddPropertyResponse instance,
) => <String, dynamic>{
  'type': instance.type,
  'status': instance.status,
  'name': instance.name,
  'description': instance.description,
  'address': instance.address,
  'price': instance.price,
  'building_area': instance.buildingArea,
  'land_area': instance.landArea,
  'updated_at': instance.updatedAt?.toIso8601String(),
  'created_at': instance.createdAt?.toIso8601String(),
  'id': instance.id,
  'image_url': instance.imageUrl,
};

MetaAddProperty _$MetaAddPropertyFromJson(Map<String, dynamic> json) =>
    MetaAddProperty(
      code: (json['code'] as num?)?.toInt(),
      status: json['status'] as String?,
      message: json['message'] as String?,
    );

Map<String, dynamic> _$MetaAddPropertyToJson(MetaAddProperty instance) =>
    <String, dynamic>{
      'code': instance.code,
      'status': instance.status,
      'message': instance.message,
    };
