import 'package:dartz/dartz.dart';

import '../../../core/core.dart';
import '../../../domain/domain.dart';
import '../../data.dart';

class PropertiesRepositoryImpl implements PropertiesRepository {
  final PropertiesApi api;
  final NetworkInfo networkInfo;

  PropertiesRepositoryImpl(this.api, this.networkInfo);
  @override
  Future<Either<Failure, AddPropertyResponse>> addProperties(
    String type,
    String status,
    String description,
    String address,
    int price,
    String image,
    int buildingArea,
    int landArea,
  ) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(Failure.noConnection());
    }
    try {
      final response = await api.addProperties(
        type,
        status,
        description,
        address,
        price,
        image,
        buildingArea,
        landArea,
      );
      if (!response.success) {
        return Left(Failure.serverError(response.message));
      }
      return Right(response.data!);
    } catch (e) {
      return Left(Failure.parseFromException(e));
    }
  }

  @override
  Future<Either<Failure, PropertiesResponse>> getProperties({
    String? search,
    String viewMode = 'simple', // atau 'full' kalau mau default full
    String? type,
    String? status,
    int? priceMin,
    int? priceMax,
    int perPage = 12,
    List<int>? ids,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(Failure.noConnection());
    }

    try {
      final response = await api.getProperties(
        search: search,
        viewMode: viewMode,
        type: type,
        status: status,
        priceMin: priceMin,
        priceMax: priceMax,
        perPage: perPage,
        ids: ids,
      );

      if (!response.success) {
        return Left(Failure.serverError(response.message));
      }

      if (response.data == null) {
        // sesuaikan dengan ctor Failure kamu
        return Left(Failure.unknownError('Data properti kosong'));
      }

      return Right(response.data!);
    } catch (e) {
      return Left(Failure.parseFromException(e));
    }
  }

  @override
  Future<Either<Failure, PropertiesSearchResponse>> searchProperties({
    String? search,
    String viewMode = 'simple',
    String? type,
    String? status,
    int? priceMin,
    int? priceMax,
    int perPage = 20,
    List<int>? ids,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(Failure.noConnection());
    }

    try {
      final response = await api.searchProperties(
        search: search,
        viewMode: viewMode,
        type: type,
        status: status,
        priceMin: priceMin,
        priceMax: priceMax,
        perPage: perPage,
        ids: ids,
      );

      if (!response.success) {
        return Left(Failure.serverError(response.message));
      }

      return Right(response.data!);
    } catch (e) {
      return Left(Failure.parseFromException(e));
    }
  }

  @override
  Future<Either<Failure, LocationsPropertiesResponse>> getLocationsProperties({
    double? swLatitude,
    double? swLongitude,
    double? neLatitude,
    double? neLongitude,
    int limit = 500,
  }) async {
    final isConnected = await networkInfo.isConnected;
    if (!isConnected) {
      return Left(Failure.noConnection());
    }

    try {
      final response = await api.getLocationProperties(
        swLatitude: swLatitude,
        swLongitude: swLongitude,
        neLatitude: neLatitude,
        neLongitude: neLongitude,
        limit: limit,
      );

      if (!response.success) {
        return Left(Failure.serverError(response.message));
      }
      return Right(response.data!);
    } catch (e) {
      return Left(Failure.parseFromException(e));
    }
  }
}
