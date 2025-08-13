import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:forui/forui.dart';
import 'package:template_clean_architecture_june_2025/di/di.dart';
import 'package:template_clean_architecture_june_2025/presentations/auth/cubit/auth_cubit.dart';

import 'router.dart';
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
        BlocProvider<AuthCubit>(create: (context) => getIt<AuthCubit>()),
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
