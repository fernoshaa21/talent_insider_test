import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/domain.dart';

part 'auth_state.freezed.dart';
part 'auth_state.g.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, failure }

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    LocalUser? user,
    String? errorMessage,
  }) = _AuthState;

  const AuthState._();

  bool get isLoading => status == AuthStatus.loading;
  bool get isAuthenticated => status == AuthStatus.authenticated;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}
