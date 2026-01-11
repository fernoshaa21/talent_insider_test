import 'package:hydrated_bloc/hydrated_bloc.dart';

import 'auth_state.dart';
import '../../../domain/usecases/auth/login_usecase.dart';
import '../../../domain/usecases/auth/register_usecase.dart';

class AuthCubit extends HydratedCubit<AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUsecase _registerUseCase;

  AuthCubit(this._loginUseCase, this._registerUseCase)
    : super(const AuthState());

  // 🔐 LOGIN
  Future<void> login({required String email, required String password}) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _loginUseCase(
      LoginParam(email: email, password: password),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (user) {
        emit(
          state.copyWith(
            status: AuthStatus.authenticated,
            user: user,
            errorMessage: null,
          ),
        );
      },
    );
  }

  // 🧾 REGISTER
  Future<void> register({
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
    required String password,
  }) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));

    final result = await _registerUseCase(
      RegisterParam(
        firstName: firstName,
        email: email,
        phone: phone,
        password: password,
        lastName: lastName,
      ),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            status: AuthStatus.failure,
            errorMessage: failure.message,
          ),
        );
      },
      (message) {
        emit(
          state.copyWith(
            status: AuthStatus.unauthenticated,
            errorMessage: null,
          ),
        );
      },
    );
  }

  // 🚪 LOGOUT
  void logout() {
    emit(
      const AuthState(
        status: AuthStatus.unauthenticated,
        user: null,
        errorMessage: null,
      ),
    );
  }

  // 🔄 Hydrated: restore dari local storage
  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    try {
      return AuthState.fromJson(json);
    } catch (_) {
      return const AuthState();
    }
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    // biasanya cuma perlu simpan user & status
    return state.toJson();
  }
}
