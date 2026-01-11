import 'package:dio/dio.dart';

import '../../../core/response/api_response.dart';
import '../../../domain/domain.dart';

abstract class AuthApi {
  Future<ApiResponse<LocalUser>> login(String email, String password);
  Future<String> register(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
  );
}

class AuthApiImpl implements AuthApi {
  final Dio dio;
  AuthApiImpl(this.dio);

  @override
  Future<ApiResponse<LocalUser>> login(String email, String password) async {
    final response = await dio.post(
      '/login',
      data: {'email': email, 'password': password},
    );
    return ApiResponse.fromResponse(response, (json) {
      return LocalUser.fromJson(json['data']);
    });
  }

  @override
  Future<String> register(
    String firstName,
    String lastName,
    String email,
    String phone,
    String password,
  ) async {
    final response = await dio.post(
      '/register',
      data: {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'phone': phone,
        'password': password,
      },
      options: Options(
        headers: {'Content-Type': 'application/x-www-form-urlencoded'},
      ),
    );

    return response.data['message']?.toString() ?? 'Register success';
  }
}
