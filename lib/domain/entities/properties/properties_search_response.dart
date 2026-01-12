// To parse this JSON data, do
//
//     final propertiesSearchResponse = propertiesSearchResponseFromJson(jsonString);

import 'dart:convert';
import 'package:json_annotation/json_annotation.dart';

part 'properties_search_response.g.dart';

PropertiesSearchResponse propertiesSearchResponseFromJson(String str) =>
    PropertiesSearchResponse.fromJson(json.decode(str));

String propertiesSearchResponseToJson(PropertiesSearchResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class PropertiesSearchResponse {
  @JsonKey(name: "meta")
  MetaSearchProperties? meta;

  @JsonKey(name: "data")
  PropertiesSearchData? data;

  @JsonKey(name: "pagination")
  PaginationSearchProperties? pagination;

  PropertiesSearchResponse({this.meta, this.data, this.pagination});

  factory PropertiesSearchResponse.fromJson(Map<String, dynamic> json) =>
      _$PropertiesSearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesSearchResponseToJson(this);
}

@JsonSerializable()
class PropertiesSearchData {
  @JsonKey(name: "data")
  List<PropertiesSearchDatum>? data;

  @JsonKey(name: "path")
  String? path;

  @JsonKey(name: "per_page")
  int? perPage;

  @JsonKey(name: "next_cursor")
  String? nextCursor;

  @JsonKey(name: "next_page_url")
  String? nextPageUrl;

  @JsonKey(name: "prev_cursor")
  String? prevCursor;

  @JsonKey(name: "prev_page_url")
  String? prevPageUrl;

  PropertiesSearchData({
    this.data,
    this.path,
    this.perPage,
    this.nextCursor,
    this.nextPageUrl,
    this.prevCursor,
    this.prevPageUrl,
  });

  factory PropertiesSearchData.fromJson(Map<String, dynamic> json) =>
      _$PropertiesSearchDataFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesSearchDataToJson(this);
}

@JsonSerializable()
class PropertiesSearchDatum {
  @JsonKey(name: "id")
  int? id;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "price")
  String? price;

  /// "rumah"
  @JsonKey(name: "type")
  PropertyTypeSearch? type;

  @JsonKey(name: "image_url")
  String? imageUrl;

  @JsonKey(name: "address")
  String? address;

  PropertiesSearchDatum({
    this.id,
    this.name,
    this.price,
    this.type,
    this.imageUrl,
    this.address,
  });

  factory PropertiesSearchDatum.fromJson(Map<String, dynamic> json) =>
      _$PropertiesSearchDatumFromJson(json);

  Map<String, dynamic> toJson() => _$PropertiesSearchDatumToJson(this);
}

@JsonSerializable()
class MetaSearchProperties {
  @JsonKey(name: "code")
  int? code;

  @JsonKey(name: "status")
  String? status;

  @JsonKey(name: "message")
  String? message;

  MetaSearchProperties({this.code, this.status, this.message});

  factory MetaSearchProperties.fromJson(Map<String, dynamic> json) =>
      _$MetaSearchPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$MetaSearchPropertiesToJson(this);
}

@JsonSerializable()
class PaginationSearchProperties {
  @JsonKey(name: "per_page")
  int? perPage;

  @JsonKey(name: "has_more_pages")
  bool? hasMorePages;

  @JsonKey(name: "next_page_url")
  String? nextPageUrl;

  @JsonKey(name: "prev_page_url")
  String? prevPageUrl;

  PaginationSearchProperties({
    this.perPage,
    this.hasMorePages,
    this.nextPageUrl,
    this.prevPageUrl,
  });

  factory PaginationSearchProperties.fromJson(Map<String, dynamic> json) =>
      _$PaginationSearchPropertiesFromJson(json);

  Map<String, dynamic> toJson() => _$PaginationSearchPropertiesToJson(this);
}

enum PropertyTypeSearch {
  @JsonValue("rumah")
  rumah,
}
