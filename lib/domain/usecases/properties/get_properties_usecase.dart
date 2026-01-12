import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart'; // Failure
import '../../../core/usecase/usecase.dart'; // UseCase base
import '../../domain.dart'; // PropertiesRepository, PropertiesResponse

class GetPropertiesUsecase
    implements UseCase<PropertiesResponse, GetPropertiesParam> {
  final PropertiesRepository repository;

  GetPropertiesUsecase(this.repository);

  @override
  Future<Either<Failure, PropertiesResponse>> call(
    GetPropertiesParam params,
  ) async {
    return await repository.getProperties(
      search: params.search,
      viewMode: params.viewMode,
      type: params.type,
      status: params.status,
      priceMin: params.priceMin,
      priceMax: params.priceMax,
      perPage: params.perPage,
      ids: params.ids,
    );
  }
}

class GetPropertiesParam extends Equatable {
  final String? search;
  final String viewMode; // 'simple' / 'full'
  final String? type; // contoh: 'rumah'
  final String? status; // 'new' / 'second'
  final int? priceMin;
  final int? priceMax;
  final int perPage;
  final List<int>? ids;

  const GetPropertiesParam({
    this.search,
    this.viewMode = 'simple', // atau 'full' kalau mau default full
    this.type,
    this.status,
    this.priceMin,
    this.priceMax,
    this.perPage = 12,
    this.ids,
  });

  @override
  List<Object?> get props => [
    search,
    viewMode,
    type,
    status,
    priceMin,
    priceMax,
    perPage,
    ids,
  ];
}
