import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:forui/forui.dart';
import 'package:trimitra_putra_mandiri/di/di.dart';
import 'package:trimitra_putra_mandiri/presentations/auth/cubit/auth_cubit.dart';
import 'package:trimitra_putra_mandiri/presentations/explore_property/cubit/explore_property_cubit.dart';
import 'package:trimitra_putra_mandiri/presentations/home/cubit/home_cubit.dart';

import 'router/router.dart';
import 'theme/theme.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    FlutterNativeSplash.remove();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = zincLight;

    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (context) => di<AuthCubit>()),
        BlocProvider<HomeCubit>(create: (context) => di<HomeCubit>()),
        BlocProvider<ExplorePropertyCubit>(
          create: (context) => di<ExplorePropertyCubit>(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: router,
        localizationsDelegates: FLocalizations.localizationsDelegates,
        supportedLocales: FLocalizations.supportedLocales,
        builder: (_, child) => FTheme(data: theme, child: child!),
        theme: theme.toApproximateMaterialTheme(),
      ),
    );
  }
}
