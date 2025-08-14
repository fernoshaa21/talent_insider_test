import 'dart:io';

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../data/utils/file_converter.dart';

part 'home_state.freezed.dart';
part 'home_state.g.dart';

@freezed
abstract class HomeState with _$HomeState {
  HomeState._();
  factory HomeState({
    String? username,
    String? time,
    String? location,
    String? status,
    String? selfiePath,
  }) = _HomeState;

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
}
