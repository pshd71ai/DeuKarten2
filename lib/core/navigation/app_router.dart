import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../screens/home/home_screen.dart';
import '../../screens/karten/karten_screen.dart';
import '../../screens/karten/learning_session_screen.dart';
import '../../screens/karten/session_result_screen.dart';
import '../../screens/tests/tests_screen.dart';
import '../../screens/tests/test_detail_screen.dart';
import '../../screens/statistik/statistik_screen.dart';
import '../../screens/profil/profil_screen.dart';
import 'scaffold_with_nav_bar.dart';

part 'app_router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(AppRouterRef ref) {
  return GoRouter(
    initialLocation: '/home',
    navigatorKey: _rootNavigatorKey,
    routes: [
      ShellRoute(
        builder: (context, state, child) => ScaffoldWithNavBar(child: child),
        routes: [
          GoRoute(
            path: '/home',
            name: 'home',
            builder: (context, state) => const HomeScreen(),
          ),
          GoRoute(
            path: '/karten',
            name: 'karten',
            builder: (context, state) => const KartenScreen(),
            routes: [
              GoRoute(
                path: 'session',
                name: 'session',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const LearningSessionScreen(),
              ),
              GoRoute(
                path: 'result',
                name: 'result',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const SessionResultScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/tests',
            name: 'tests',
            builder: (context, state) => const TestsScreen(),
            routes: [
              GoRoute(
                path: ':id',
                name: 'test_detail',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) {
                  final id = state.pathParameters['id'] ?? '';
                  return TestDetailScreen(id: id);
                },
              ),
            ],
          ),
          GoRoute(
            path: '/statistik',
            name: 'statistik',
            builder: (context, state) => const StatistikScreen(),
          ),
          GoRoute(
            path: '/profil',
            name: 'profil',
            builder: (context, state) => const ProfilScreen(),
          ),
        ],
      ),
    ],
  );
}
