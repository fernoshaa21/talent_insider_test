import 'package:dartz/dartz.dart';
import 'package:trimitra_putra_mandiri/domain/domain.dart';

import '../../../core/errors/failure.dart';

abstract class PropertiesRepository {
  Future<Either<Failure, AddPropertyResponse>> addProperties(
    String type,
    String status,
    String description,
    String address,
    int price,
    String image,
    int buildingArea,
    int landArea,
  );
  Future<Either<Failure, PropertiesResponse>> getProperties({
    String? search,
    String viewMode,
    String? type,
    String? status,
    int? priceMin,
    int? priceMax,
    int perPage,
    List<int>? ids,
  });
  Future<Either<Failure, PropertiesSearchResponse>> searchProperties({
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
