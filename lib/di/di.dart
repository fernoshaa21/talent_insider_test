import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:template_clean_architecture_june_2025/config.dart';

import 'package:template_clean_architecture_june_2025/data/utils/dio_token_interceptor.dart';
import 'package:template_clean_architecture_june_2025/presentations/auth/cubit/auth_cubit.dart';

import '../core/network/network.dart';

final di = GetIt.I;

Future<void> setupInjection() async {
  try {
    _utils();

    _datasources();
    _repositories();
    _useCases();

    _cubits();
  } catch (e) {
    print(e);
  }
}

void _datasources() {
  // di.registerSingleton<AuthApi>(AuthApiImpl(di()));
}

void _repositories() {
  // _repositories
  // di.registerSingleton<AuthRepository>(AuthRepositoryImpl(di(), di()));
}

void _useCases() {
  /// auth
  // di.registerSingleton<LoginUseCase>(LoginUseCase(di()));
}

void _cubits() {
  //Cubits use MultiBlocProvider (RegisterSingleton Injections)
  di.registerLazySingleton(() => AuthCubit());
}

void _utils() {
  // 1. Basic utilities

  di.registerLazySingleton(() => Connectivity());
  di.registerSingleton<NetworkInfo>(NetworkInfoImpl(di()));

  // 3. Shared Preferences
  di.registerSingletonAsync<SharedPreferences>(
    () => SharedPreferences.getInstance(),
  );

  // 4. Network Client
  di.registerLazySingleton(() {
    final dio = Dio();
    dio.options.baseUrl = AppConfig.baseUrl;
    dio.interceptors.add(DioTokenInterceptor(di.call, di()));
    dio.interceptors.add(LogInterceptor());
    return dio;
  });
}
