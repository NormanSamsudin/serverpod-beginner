import 'package:auto_route/auto_route.dart';
import 'package:serverpod_hackathon_flutter/views/screens/home_screen.dart';
import 'package:serverpod_hackathon_flutter/views/screens/profile_screen.dart';
import 'package:serverpod_hackathon_flutter/views/screens/settings_screen.dart';
import 'package:serverpod_hackathon_flutter/views/screens/main_navigation_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: MainNavigationRoute.page,
      initial: true,
      children: [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}
