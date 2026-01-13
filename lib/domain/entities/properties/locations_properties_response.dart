// To parse this JSON data, do
//
//     final locationsPropertiesResponse = locationsPropertiesResponseFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'locations_properties_response.g.dart';

LocationsPropertiesResponse locationsPropertiesResponseFromJson(String str) =>
    LocationsPropertiesResponse.fromJson(json.decode(str));

String locationsPropertiesResponseToJson(LocationsPropertiesResponse data) =>
    json.encode(data.toJson());

@JsonSerializable()
class LocationsPropertiesResponse {
  @JsonKey(name: "meta")
  LocationsPropertiesResponseMeta? meta;
  @JsonKey(name: "data")
  List<int>? data;

  LocationsPropertiesResponse({this.meta, this.data});

  factory LocationsPropertiesResponse.fromJson(Map<String, dynamic> json) =>
      _$LocationsPropertiesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$LocationsPropertiesResponseToJson(this);
}

@JsonSerializable()
class LocationsPropertiesResponseMeta {
  @JsonKey(name: "code")
  int? code;
  @JsonKey(name: "status")
  String? status;
  @JsonKey(name: "message")
  String? message;

  LocationsPropertiesResponseMeta({
    this.code,
    this.status,
    this.message,
  }); // Perbaikan konstruktor

  factory LocationsPropertiesResponseMeta.fromJson(Map<String, dynamic> json) =>
      _$LocationsPropertiesResponseMetaFromJson(json);

  Map<String, dynamic> toJson() =>
      _$LocationsPropertiesResponseMetaToJson(this);
}
