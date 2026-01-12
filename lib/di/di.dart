import 'package:connectivity_plus/connectivity_plus.dart';

import 'package:dio/dio.dart';

import 'package:get_it/get_it.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:trimitra_putra_mandiri/config.dart';
import 'package:trimitra_putra_mandiri/data/utils/dio_token_interceptor.dart';
import 'package:trimitra_putra_mandiri/domain/usecases/auth/register_usecase.dart';
import 'package:trimitra_putra_mandiri/presentations/auth/cubit/auth_cubit.dart';
import 'package:trimitra_putra_mandiri/presentations/explore_property/cubit/explore_property_cubit.dart';
import 'package:trimitra_putra_mandiri/presentations/home/cubit/home_cubit.dart';

import '../core/network/network.dart';
import '../data/data.dart';
import '../data/datasources/datasources.dart';
import '../domain/domain.dart';
import '../router/router.dart';

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
  di.registerSingleton<AuthApi>(AuthApiImpl(di()));
  di.registerSingleton<PropertiesApi>(PropertiesApiImpl(di()));
}

void _repositories() {
  // _repositories
  di.registerSingleton<AuthRepository>(AuthRepositoryImpl(di(), di()));
  di.registerSingleton<PropertiesRepository>(
    PropertiesRepositoryImpl(di(), di()),
  );
}

void _useCases() {
  /// auth
  di.registerSingleton<LoginUseCase>(LoginUseCase(di()));
  di.registerSingleton<RegisterUsecase>(RegisterUsecase(di()));
  di.registerSingleton<GetPropertiesUsecase>(GetPropertiesUsecase(di()));
  di.registerSingleton<SearchPropertiesUsecase>(SearchPropertiesUsecase(di()));
}

void _cubits() {
  //Cubits use MultiBlocProvider (RegisterSingleton Injections)
  di.registerLazySingleton(() => AuthCubit(di(), di()));
  di.registerLazySingleton(() => HomeCubit());
  di.registerLazySingleton(() => ExplorePropertyCubit(di(), di()));
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
    dio.interceptors.add(
      DioTokenInterceptor(
        () => di<AuthCubit>(),
        rootNavigatorKey.currentContext,
      ),
    );
    dio.interceptors.add(LogInterceptor());
    return dio;
  });
}
