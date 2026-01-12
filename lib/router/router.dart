import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../lib.dart';

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
    GoRoute(
      path: '/search_properties',
      name: 'search_properties',
      builder: (context, state) => const SearchPropertyView(),
    ),
    GoRoute(
      path: '/result_properties_view',
      name: 'result_properties_view',
      builder: (context, state) {
        // ambil keyword yang dikirim lewat extra
        final keyword = state.extra as String? ?? '';
        return SearchPropertyResultView(initialKeyword: keyword);
      },
    ),
  ],
);
