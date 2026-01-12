import 'package:dio/dio.dart';

import '../../../core/response/api_response.dart';
import '../../../domain/domain.dart';

abstract class PropertiesApi {
  Future<ApiResponse<AddPropertyResponse>> addProperties(
    String type,
    String status,
    String description,
    String address,
    int price,
    String image,
    int buildingArea,
    int landArea,
  );
  Future<ApiResponse<PropertiesResponse>> getProperties({
    String? search,
    String viewMode,
    String? type,
    String? status,
    int? priceMin,
    int? priceMax,
    int perPage,
    List<int>? ids,
  });
  Future<ApiResponse<PropertiesSearchResponse>> searchProperties({
    String? search,
    String viewMode,
    String? type,
    String? status,
    int? priceMin,
    int? priceMax,
    int perPage,
    List<int>? ids,
  });
}

class PropertiesApiImpl implements PropertiesApi {
  final Dio dio;

  PropertiesApiImpl(this.dio);

  @override
  Future<ApiResponse<AddPropertyResponse>> addProperties(
    String type,
    String status,
    String description,
    String address,
    int price,
    String image,
    int buildingArea,
    int landArea,
  ) async {
    final response = await dio.post(
      '/properties',
      data: {
        'type': type,
        'status': status,
        'description': description,
        'address': address,
        'price': price,
        'image': image,
        'building_area': buildingArea,
        'land_area': landArea,
      },
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    return ApiResponse.fromResponse(response, (json) {
      return AddPropertyResponse.fromJson(json['data']);
    });
  }

  @override
  Future<ApiResponse<PropertiesResponse>> getProperties({
    String? search,
    String viewMode = 'simple',
    String? type,
    String? status,
    int? priceMin,
    int? priceMax,
    int perPage = 12,
    List<int>? ids,
  }) async {
    // build query params, buang yang null
    final query = <String, dynamic>{
      if (search != null && search.isNotEmpty) 'search': search,
      'view_mode': viewMode, // default simple/full
      if (type != null && type.isNotEmpty) 'type': type,
      if (status != null && status.isNotEmpty) 'status': status,
      if (priceMin != null) 'price_min': priceMin,
      if (priceMax != null) 'price_max': priceMax,
      'per_page': perPage,
      if (ids != null && ids.isNotEmpty) 'ids[]': ids,
    };

    final response = await dio.get('/properties', queryParameters: query);

    return ApiResponse.fromResponse(response, (json) {
      return PropertiesResponse.fromJson(json);
    });
  }

  @override
  Future<ApiResponse<PropertiesSearchResponse>> searchProperties({
    String? search,
    String viewMode = 'simple',
    String? type,
    String? status,
    int? priceMin,
    int? priceMax,
    int perPage = 20,
    List<int>? ids,
  }) async {
    final body = <String, dynamic>{
      if (search != null && search.isNotEmpty) 'search': search,
      'ids': ids ?? <int>[],
      'view_mode': viewMode,
      if (type != null && type.isNotEmpty) 'type': type,
      if (status != null && status.isNotEmpty) 'status': status,
      'price_min': priceMin ?? 0,
      'price_max': priceMax ?? 0,
      'per_page': perPage,
    };

    final response = await dio.post('/properties/search', data: body);

    // json = { meta, data, pagination }
    return ApiResponse.fromResponse(response, (json) {
      return PropertiesSearchResponse.fromJson(json);
    });
  }
}
