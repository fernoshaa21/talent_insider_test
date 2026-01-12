// To parse this JSON data, do
//
//     final propertiesResponse = propertiesResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'properties_response.g.dart';

PropertiesResponse propertiesResponseFromJson(String str) =>
    PropertiesResponse.fromJson(json.decode(str));

String propertiesResponseToJson(PropertiesResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class PropertiesResponse {
  @JsonKey(name: "meta")
  MetaGetProperties? meta;
  @JsonKey(name: "data")
  PropertiesData? data;
  @JsonKey(name: "pagination")
  PaginationGetProperties? pagination;

  PropertiesResponse({this.meta, this.data, this.pagination});

  factory PropertiesResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesResponseToJson(this);
}

@JsonSerializable()
class PropertiesData {
  @JsonKey(name: "data")
  List<PropertiesDatum>? data;
  @JsonKey(name: "path")
  String? path;
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "next_cursor")
  String? nextCursor;
  @JsonKey(name: "next_page_url")
  String? nextPageUrl;
  @JsonKey(name: "prev_cursor")
  dynamic prevCursor;
  @JsonKey(name: "prev_page_url")
  dynamic prevPageUrl;

  PropertiesData({
    this.data,
    this.path,
    this.perPage,
    this.nextCursor,
    this.nextPageUrl,
    this.prevCursor,
    this.prevPageUrl,
  });

  factory PropertiesData.fromJson(Map<String, dynamic> json) =>
      _$PropertiesDataFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesDataToJson(this);
}

@JsonSerializable()
class PropertiesDatum {
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "price")
  String? price;
  @JsonKey(name: "type")
  Type? type;
  @JsonKey(name: "image_url")
  String? imageUrl;
  @JsonKey(name: "address")
  String? address;

  PropertiesDatum({
    this.id,
    this.name,
    this.price,
    this.type,
    this.imageUrl,
    this.address,
  });

  factory PropertiesDatum.fromJson(Map<String, dynamic> json) =>
      _$PropertiesDatumFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesDatumToJson(this);
}

enum Type {
  @JsonValue("rumah")
  RUMAH,
}

final typeValues = EnumValues({"rumah": Type.RUMAH});

@JsonSerializable()
class MetaGetProperties {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;

  MetaGetProperties({this.code, this.status, this.message});

  factory MetaGetProperties.fromJson(Map<String, dynamic> json) =>
      _$MetaGetPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$MetaGetPropertiesToJson(this);
}

@JsonSerializable()
class PaginationGetProperties {
  @JsonKey(name: "per_page")
  int? perPage;
  @JsonKey(name: "has_more_pages")
  bool? hasMorePages;
  @JsonKey(name: "next_page_url")
  String? nextPageUrl;
  @JsonKey(name: "prev_page_url")
  dynamic prevPageUrl;

  PaginationGetProperties({
    this.perPage,
    this.hasMorePages,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory PaginationGetProperties.fromJson(Map<String, dynamic> json) =>
      _$PaginationGetPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationGetPropertiesToJson(this);
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
