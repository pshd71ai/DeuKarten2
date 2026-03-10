import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'core/theme/app_theme.dart';
import 'screens/home_screen.dart';
import 'features/cards/cards.dart';
import 'features/tests/tests.dart';
import 'features/statistics/statistics.dart';
import 'features/ki_teacher/ki_teacher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Set preferred orientations
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  runApp(
    const ProviderScope(
      child: DeuKartenApp(),
    ),
  );
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/cards',
      builder: (context, state) => const CardListScreen(),
    ),
    GoRoute(
      path: '/tests',
      builder: (context, state) => const TestListScreen(),
    ),
    GoRoute(
      path: '/statistics',
      builder: (context, state) => const StatisticsScreen(),
    ),
    GoRoute(
      path: '/ki-teacher',
      builder: (context, state) => const KiTeacherScreen(),
    ),
  ],
);

class DeuKartenApp extends ConsumerWidget {
  const DeuKartenApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = AppTheme.lightTheme;

    return MaterialApp.router(
      title: 'DeuKarten',
      debugShowCheckedModeBanner: false,
      theme: theme,
      routerConfig: _router,
    );
  }
}
