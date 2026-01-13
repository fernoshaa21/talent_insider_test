import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart'; // Failure
import '../../../core/usecase/usecase.dart'; // UseCase base
import '../../domain.dart'; // PropertiesRepository, LocationsPropertiesResponse

class GetLocationsPropertiesUsecase
    implements
        UseCase<LocationsPropertiesResponse, GetLocationsPropertiesParam> {
  final PropertiesRepository repository;

  GetLocationsPropertiesUsecase(this.repository);

  @override
  Future<Either<Failure, LocationsPropertiesResponse>> call(
    GetLocationsPropertiesParam params,
  ) async {
    return await repository.getLocationsProperties(
      swLatitude: params.swLatitude,
      swLongitude: params.swLongitude,
      neLatitude: params.neLatitude,
      neLongitude: params.neLongitude,
      limit: params.limit,
    );
  }
}

class GetLocationsPropertiesParam extends Equatable {
  final double? swLatitude;
  final double? swLongitude;
  final double? neLatitude;
  final double? neLongitude;
  final int limit;

  const GetLocationsPropertiesParam({
    this.swLatitude,
    this.swLongitude,
    this.neLatitude,
    this.neLongitude,
    this.limit = 500, // Default limit as per the API
  });

  @override
  List<Object?> get props => [
    swLatitude,
    swLongitude,
    neLatitude,
    neLongitude,
    limit,
  ];
}
