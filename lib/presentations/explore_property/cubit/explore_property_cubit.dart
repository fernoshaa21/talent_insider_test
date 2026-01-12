import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:trimitra_putra_mandiri/domain/usecases/properties/search_properties_usecase.dart';

import '../../../domain/usecases/properties/get_properties_usecase.dart';
import 'explore_property_state.dart';

class ExplorePropertyCubit extends HydratedCubit<ExplorePropertyState> {
  final GetPropertiesUsecase _getPropertiesUsecase;
  final SearchPropertiesUsecase _searchPropertiesUsecase;

  ExplorePropertyCubit(
    this._getPropertiesUsecase,
    this._searchPropertiesUsecase,
  ) : super(const ExplorePropertyState());

  /// 🏡 GET PROPERTIES
  Future<void> getProperties({
    String? search,
    String viewMode = 'simple', // atau 'full'
    String? type,
    String? status,
    int? priceMin,
    int? priceMax,
    int perPage = 12,
    List<int>? ids,
  }) async {
    emit(
      state.copyWith(status: ExplorePropertyStatus.loading, errorMessage: null),
    );

    final result = await _getPropertiesUsecase(
      GetPropertiesParam(
        search: search,
        viewMode: viewMode,
        type: type,
        status: status,
        priceMin: priceMin,
        priceMax: priceMax,
        perPage: perPage,
        ids: ids,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ExplorePropertyStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (propertiesResponse) {
        emit(
          state.copyWith(
            status: ExplorePropertyStatus.success,
            properties: propertiesResponse,
            errorMessage: null,
          ),
        );
      },
    );
  }

  Future<void> searchProperties({
    String? search,
    String viewMode = 'simple', // atau 'full'
    String? type,
    String? status,
    int? priceMin,
    int? priceMax,
    int perPage = 20, // default search API pakai 20
    List<int>? ids,
  }) async {
    emit(
      state.copyWith(status: ExplorePropertyStatus.loading, errorMessage: null),
    );

    final result = await _searchPropertiesUsecase(
      SearchPropertiesParam(
        search: search,
        viewMode: viewMode,
        type: type,
        status: status,
        priceMin: priceMin,
        priceMax: priceMax,
        perPage: perPage,
        ids: ids,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: ExplorePropertyStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (searchResponse) {
        emit(
          state.copyWith(
            status: ExplorePropertyStatus.success,
            searchProperties: searchResponse, // simpan hasil search
            errorMessage: null,
          ),
        );
      },
    );
  }

  void clearSearchResults() {
    emit(
      state.copyWith(
        searchProperties: null,
        // kalau mau status balik ke initial:
        status: ExplorePropertyStatus.initial,
        errorMessage: null,
      ),
    );
  }

  // ---- Hydrated ----
  @override
  ExplorePropertyState? fromJson(Map<String, dynamic> json) {
    try {
      return ExplorePropertyState.fromJson(json);
    } catch (_) {
      return const ExplorePropertyState();
    }
  }

  @override
  Map<String, dynamic>? toJson(ExplorePropertyState state) {
    return state.toJson();
  }
}
