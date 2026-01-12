import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart'; // Failure
import '../../../core/usecase/usecase.dart'; // UseCase base
import '../../domain.dart'; // PropertiesRepository, PropertiesSearchResponse

class SearchPropertiesUsecase
    implements UseCase<PropertiesSearchResponse, SearchPropertiesParam> {
  final PropertiesRepository repository;

  SearchPropertiesUsecase(this.repository);

  @override
  Future<Either<Failure, PropertiesSearchResponse>> call(
    SearchPropertiesParam params,
  ) async {
    return await repository.searchProperties(
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

class SearchPropertiesParam extends Equatable {
  final String? search;
  final String viewMode; // 'simple' / 'full'
  final String? type; // contoh: 'rumah'
  final String? status; // 'new' / 'second'
  final int? priceMin;
  final int? priceMax;
  final int perPage;
  final List<int>? ids;

  const SearchPropertiesParam({
    this.search,
    this.viewMode = 'simple', // default sama dengan getProperties
    this.type,
    this.status,
    this.priceMin,
    this.priceMax,
    this.perPage = 20, // sesuai contoh request search
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
