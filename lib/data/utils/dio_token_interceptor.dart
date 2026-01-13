import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../lib.dart';

class DioTokenInterceptor extends Interceptor {
  final AuthCubit Function() getAuthCubit;
  final BuildContext? context;

  DioTokenInterceptor(this.getAuthCubit, this.context);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    final authCubit = getAuthCubit();
    final user = authCubit.state.user;

    // --- skip auth untuk login/register kalau perlu ---
    final path = options.path;
    final needAuth = !(path.contains('/login') || path.contains('/register'));

    if (needAuth && user?.accessToken != null) {
      options.headers['Authorization'] = 'Bearer ${user!.accessToken}';
    }

    // Kalau kamu perlu handle dio.user_id seperti sebelumnya:
    if (options.data is Map &&
        (options.data as Map).containsKey('dio.user_id')) {
      options.data = <String, dynamic>{
        ...(options.data as Map)..remove('dio.user_id'),
      };
    } else if (options.queryParameters.containsKey('dio.user_id')) {
      options.queryParameters = <String, dynamic>{
        ...(options.queryParameters)..remove('dio.user_id'),
      };
    } else if (options.data is FormData &&
        (options.data as FormData).fields.any((e) => e.key == 'dio.user_id')) {
      (options.data as FormData).fields.removeWhere(
        (e) => e.key == 'dio.user_id',
      );
    }

    return handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == HttpStatus.unauthorized) {
      // Token invalid/expired -> paksa logout & balik ke login
      try {
        getAuthCubit().logout();
      } catch (_) {}

      final ctx = context ?? rootNavigatorKey.currentContext;
      if (ctx != null) {
        ctx.goNamed('auth');
      }
    }
    return handler.next(err);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    return handler.next(response);
  }
}

Map<String, bool> get useUserId => {'dio.user_id': true};
