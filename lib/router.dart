import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:trimitra_putra_mandiri/presentations/auth/view/auth_view.dart';
import 'package:trimitra_putra_mandiri/presentations/auth/view/register_view.dart';
import 'package:trimitra_putra_mandiri/presentations/explore_property/view/explore_property_view.dart';
import 'package:trimitra_putra_mandiri/presentations/home/view/home_view.dart';

final dashboardNavigatorKey = GlobalKey<NavigatorState>();
final rootNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/auth',
  routes: [
    GoRoute(
      path: '/auth',
      name: 'auth',
      builder: (context, state) => const AuthView(),
    ),
    GoRoute(
      path: '/register',
      name: 'register',
      builder: (context, state) => const RegisterView(),
    ),
    GoRoute(
      path: '/home',
      name: 'home',
      builder: (context, state) => const HomeView(),
    ),
    GoRoute(
      path: '/explore_property',
      name: 'explore_property',
      builder: (context, state) => const ExplorePropertyView(),
    ),
  ],
);
