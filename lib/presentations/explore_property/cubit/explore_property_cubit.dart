import 'package:hydrated_bloc/hydrated_bloc.dart';

import '../../../domain/usecases/properties/get_properties_usecase.dart';
import '../../../domain/entities/properties/properties_response.dart';
import 'explore_property_state.dart';

class ExplorePropertyCubit extends HydratedCubit<ExplorePropertyState> {
  final GetPropertiesUsecase _getPropertiesUsecase;

  ExplorePropertyCubit(this._getPropertiesUsecase)
    : super(const ExplorePropertyState());

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
