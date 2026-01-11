import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import '../../../core/usecase/usecase.dart';
import '../../domain.dart';

class LoginUseCase implements UseCase<LocalUser, LoginParam> {
  final AuthRepository repository;

  LoginUseCase(this.repository);

  @override
  Future<Either<Failure, LocalUser>> call(LoginParam params) async {
    return await repository.login(params.email, params.password);
  }
}

class LoginParam extends Equatable {
  final String email;
  final String password;

  const LoginParam({required this.email, required this.password});

  @override
  List<Object?> get props => [email, password];
}
