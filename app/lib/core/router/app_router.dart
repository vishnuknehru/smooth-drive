import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/drive/presentation/drive_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/summary/presentation/summary_screen.dart';

part 'app_router.g.dart';

abstract final class Routes {
  static const home = '/';
  static const drive = '/drive';
  static const settings = '/settings';

  static String summary(String journeyId) => '/summary/$journeyId';
}

@Riverpod(keepAlive: true)
GoRouter appRouter(Ref ref) => GoRouter(
  routes: [
    GoRoute(path: Routes.home, builder: (context, state) => const HomeScreen()),
    GoRoute(
      path: Routes.drive,
      builder: (context, state) => const DriveScreen(),
    ),
    GoRoute(
      path: '/summary/:journeyId',
      builder: (context, state) =>
          SummaryScreen(journeyId: state.pathParameters['journeyId']!),
    ),
    GoRoute(
      path: Routes.settings,
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
