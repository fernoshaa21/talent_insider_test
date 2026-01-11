import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../core/core.dart';
import '../../../core/usecase/usecase.dart';
import '../../domain.dart';

class RegisterUsecase implements UseCase<String, RegisterParam> {
  final AuthRepository repository;

  RegisterUsecase(this.repository);

  @override
  Future<Either<Failure, String>> call(RegisterParam params) async {
    return await repository.register(
      params.firstName,
      params.lastName,
      params.email,
      params.phone,
      params.password,
    );
  }
}

class RegisterParam extends Equatable {
  final String firstName;
  final String lastName;
  final String email;
  final String phone;
  final String password;

  const RegisterParam({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.phone,
    required this.password,
  });

  @override
  List<Object?> get props => [firstName, email, phone, password, lastName];
}
