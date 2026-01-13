import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'explore_property_state.freezed.dart';
part 'explore_property_state.g.dart';

enum ExplorePropertyStatus {
  initial,
  loading,
  success,
  unauthenticated,
  failure,
}

@freezed
abstract class ExplorePropertyState with _$ExplorePropertyState {
  const factory ExplorePropertyState({
    @Default(ExplorePropertyStatus.initial) ExplorePropertyStatus status,
    PropertiesResponse? properties,
    PropertiesSearchResponse? searchProperties,
    LocationsPropertiesResponse? locationProperties,
    String? errorMessage,
  }) = _ExplorePropertyState;

  const ExplorePropertyState._();

  bool get isLoading => status == ExplorePropertyStatus.loading;
  bool get isSuccess => status == ExplorePropertyStatus.success;

  factory ExplorePropertyState.fromJson(Map<String, dynamic> json) =>
      _$ExplorePropertyStateFromJson(json);
}
