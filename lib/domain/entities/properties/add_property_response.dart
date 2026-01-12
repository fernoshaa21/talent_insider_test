// To parse this JSON data, do
//
//     final addPropertyResponse = addPropertyResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';

part 'add_property_response.g.dart';

@JsonSerializable()
class AddPropertyResponse {
  @JsonKey(name: "type")
  String? type;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "description")
  String? description;
  @JsonKey(name: "address")
  String? address;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "building_area")
  int? buildingArea;
  @JsonKey(name: "land_area")
  int? landArea;
  @JsonKey(name: "updated_at")
  DateTime? updatedAt;
  @JsonKey(name: "created_at")
  DateTime? createdAt;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "image_url")
  String? imageUrl;

  AddPropertyResponse({
    this.type,
    this.status,
    this.name,
    this.description,
    this.address,
    this.price,
    this.buildingArea,
    this.landArea,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.imageUrl,
  });

  factory AddPropertyResponse.fromJson(Map<String, dynamic> json) =>
      _$AddPropertyResponseFromJson(json);

  Map<String, dynamic> toJson() => _$AddPropertyResponseToJson(this);
}

@JsonSerializable()
class MetaAddProperty {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;

  MetaAddProperty({this.code, this.status, this.message});

  factory MetaAddProperty.fromJson(Map<String, dynamic> json) =>
      _$MetaAddPropertyFromJson(json);

  Map<String, dynamic> toJson() => _$MetaAddPropertyToJson(this);
}
