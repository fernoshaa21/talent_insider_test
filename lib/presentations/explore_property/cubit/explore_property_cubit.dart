import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../lib.dart';
import 'explore_property_state.dart';

class ExplorePropertyCubit extends HydratedCubit<ExplorePropertyState> {
  final GetPropertiesUsecase _getPropertiesUsecase;
  final SearchPropertiesUsecase _searchPropertiesUsecase;
  final GetLocationsPropertiesUsecase _getLocationsPropertiesUsecase;

  ExplorePropertyCubit(
    this._getPropertiesUsecase,
    this._searchPropertiesUsecase,
    this._getLocationsPropertiesUsecase,
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

  Future<void> getLocationProperties({
    double? swLatitude,
    double? swLongitude,
    double? neLatitude,
    double? neLongitude,
    int limit = 500,
  }) async {
    emit(
      state.copyWith(status: ExplorePropertyStatus.loading, errorMessage: null),
    );

    final result = await _getLocationsPropertiesUsecase(
      GetLocationsPropertiesParam(
        swLatitude: swLatitude,
        swLongitude: swLongitude,
        neLatitude: neLatitude,
        neLongitude: neLongitude,
        limit: limit,
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
      (locationsPropertiesResponse) {
        emit(
          state.copyWith(
            status: ExplorePropertyStatus.success,
            locationProperties: locationsPropertiesResponse,
            errorMessage: null,
          ),
        );
      },
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
