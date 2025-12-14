import 'package:auto_route/auto_route.dart';
import 'package:serverpod_hackathon_flutter/views/screens/auth_wrapper_screen.dart';
import 'package:serverpod_hackathon_flutter/views/screens/home_screen.dart';
import 'package:serverpod_hackathon_flutter/views/screens/login_screen.dart';
import 'package:serverpod_hackathon_flutter/views/screens/profile_screen.dart';
import 'package:serverpod_hackathon_flutter/views/screens/register_screen.dart';
import 'package:serverpod_hackathon_flutter/views/screens/settings_screen.dart';
import 'package:serverpod_hackathon_flutter/views/screens/main_navigation_screen.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    // Auth wrapper as initial route - checks auth state
    AutoRoute(page: AuthWrapperRoute.page, initial: true),

    // Login and register routes
    AutoRoute(page: LoginRoute.page),
    AutoRoute(page: RegisterRoute.page),

    // Main app (protected, requires auth)
    AutoRoute(
      page: MainNavigationRoute.page,
      children: [
        AutoRoute(page: HomeRoute.page, initial: true),
        AutoRoute(page: ProfileRoute.page),
        AutoRoute(page: SettingsRoute.page),
      ],
    ),
  ];
}
