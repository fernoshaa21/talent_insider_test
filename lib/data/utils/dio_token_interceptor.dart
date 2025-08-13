import 'dart:io';

import 'package:dio/dio.dart';
import 'package:go_router/go_router.dart';
import 'package:template_clean_architecture_june_2025/presentations/auth/cubit/auth_cubit.dart';

import '../../presentations/auth/auth.dart';

// import 'package:flutter_news_app/config/flavor_config.dart';

class DioTokenInterceptor implements InterceptorsWrapper {
  // final AuthCubit authCubit;
  final AuthCubit Function() getAuthCubit;
  final GoRoute router;

  DioTokenInterceptor(this.getAuthCubit, this.router);
  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      // getAuthCubit().resetUser();
    }
    return handler.next(err);
  }

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    // var currentUser = getAuthCubit().state.user;
    // var loginData = {

    //   'version': AppConfig.package.version,
    //   'buildNumber': AppConfig.package.buildNumber,
    // }.map((key, value) => MapEntry(key, value.toString()));
    // if (options.method == 'POST') {
    //   if (options.data is FormData) {
    //     (options.data as FormData).fields.addAll(loginData.entries);
    //   }
    // } else {
    //   options.queryParameters.addAll(loginData);
    // }
    // if (currentUser?.token != null) {
    //   options.headers['Authorization'] = 'Bearer ${currentUser?.token}';
    // }

    /// xxx url encode if post
    if (options.method == 'POST' || options.method == 'PUT') {
      if (options.data is FormData) {
        options.headers['Content-Type'] = 'multipart/form-data';
      } else if (options.data is Map || options.data is String) {
        // For JSON data, use application/json
        options.headers['Content-Type'] = 'application/json';
      }
    }
    if (options.data is Map &&
        (options.data as Map).containsKey('dio.user_id')) {
      options.data = <String, dynamic>{
        ...(options.data as Map)..remove('dio.user_id'),
        // 'userId': currentUser?.userId,
      };
    } else if (options.queryParameters.containsKey('dio.user_id')) {
      options.queryParameters = <String, dynamic>{
        ...(options.queryParameters)..remove('dio.user_id'),
        // 'userId': currentUser?.userId,
      };
    } else if (options.data is FormData &&
        (options.data as FormData).fields.any(
          (element) => element.key == 'dio.user_id',
        )) {
      // (options.data as FormData).fields.add(
      //   // MapEntry('userId', currentUser?.userId ?? ''),
      // );
      (options.data as FormData).fields.removeWhere(
        (element) => element.key == 'dio.user_id',
      );
    }
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) async {
    return handler.next(response);
  }
}

Map get useUserId {
  return {'dio.user_id': true};
}
