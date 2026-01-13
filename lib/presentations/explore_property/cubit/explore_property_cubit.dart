import 'package:hydrated_bloc/hydrated_bloc.dart';
import '../../../lib.dart';
import 'explore_property_state.dart';

class ExplorePropertyCubit extends HydratedCubit<ExplorePropertyState> {
  final GetPropertiesUsecase _getPropertiesUsecase;
  final SearchPropertiesUsecase _searchPropertiesUsecase;
  final GetLocationsPropertiesUsecase _getLocationsPropertiesUsecase;
  final AddPropertiesUsecase _addPropertiesUsecase;

  ExplorePropertyCubit(
    this._getPropertiesUsecase,
    this._searchPropertiesUsecase,
    this._getLocationsPropertiesUsecase,
    this._addPropertiesUsecase,
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

  // Method untuk menambahkan properti baru
  Future<void> addProperty({
    required String type,
    required String status,
    required String name,
    required String description,
    required String address,
    required int price,
    String? image,
    required int buildingArea,
    required int landArea,
  }) async {
    emit(
      state.copyWith(status: ExplorePropertyStatus.loading, errorMessage: null),
    );

    final result = await _addPropertiesUsecase(
      AddPropertiesParam(
        type: type,
        status: status,
        name: name,
        description: description,
        address: address,
        price: price,
        image: image ?? '',
        buildingArea: buildingArea,
        landArea: landArea,
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
      (propertyResponse) {
        emit(
          state.copyWith(
            status: ExplorePropertyStatus.success,
            addPropertyResponse:
                propertyResponse, // Simpan properti yang baru ditambahkan
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
