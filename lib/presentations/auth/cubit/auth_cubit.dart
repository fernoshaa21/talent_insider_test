import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:trimitra_putra_mandiri/presentations/auth/cubit/auth_state.dart';

@injectable
class AuthCubit extends HydratedCubit<AuthState> {
  AuthCubit() : super(AuthState());
  static const _dummyUsers = {'admin': '123456', 'user': 'password'};

  Future<void> login(String username, String password) async {
    emit(state.copyWith(status: AuthStatus.loading, errorMessage: null));
    await Future.delayed(const Duration(milliseconds: 700));

    final ok = _dummyUsers[username] == password;
    if (ok) {
      emit(
        state.copyWith(
          status: AuthStatus.authenticated,
          username: username,
          errorMessage: null,
        ),
      );
    } else {
      emit(
        state.copyWith(
          status: AuthStatus.failure,
          errorMessage: 'Username atau password salah.',
        ),
      );
      emit(
        state.copyWith(status: AuthStatus.unauthenticated, errorMessage: null),
      );
    }
  }

  @override
  AuthState? fromJson(Map<String, dynamic> json) {
    return AuthState.fromJson(json);
  }

  @override
  Map<String, dynamic>? toJson(AuthState state) {
    return state.toJson();
  }
}
