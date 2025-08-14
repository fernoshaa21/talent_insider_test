import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trimitra_putra_mandiri/presentations/auth/view/auth_view.dart';
import 'package:trimitra_putra_mandiri/presentations/home/view/home_view.dart';

final dashboardNavigatorKey = GlobalKey<NavigatorState>();
final rootNavigatorKey = GlobalKey<NavigatorState>();
final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/auth',
  routes: [
    GoRoute(path: '/auth', builder: (context, state) => const AuthView()),
    GoRoute(path: '/home', builder: (context, state) => const HomeView()),
    // GoRoute(
    //   path: '/',
    //   name: 'splash',
    //   builder: (context, state) => const SplashView(),
    // ),
    // ShellRoute(
    //   navigatorKey: dashboardNavigatorKey,
    //   builder: (context, state, child) => DashboardView(child: child),

    //   routes: [
    //     GoRoute(path: '/home', builder: (context, state) => const HomeView()),
    //     GoRoute(path: '/user', builder: (context, state) => const UserView()),
    //   ],
    // ),
  ],
);
