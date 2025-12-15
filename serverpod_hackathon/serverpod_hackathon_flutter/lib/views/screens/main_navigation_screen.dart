import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_hackathon_flutter/generated/l10n.dart';
import 'package:serverpod_hackathon_flutter/router/app_router.dart';

@RoutePage()
class MainNavigationScreen extends StatelessWidget {
  const MainNavigationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AutoTabsScaffold(
      routes: const [
        HomeRoute(),
        MenuRoute(),
        ProfileRoute(),
        SettingsRoute(),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          items: [
            BottomNavigationBarItem(
              icon: const Icon(Icons.home),
              label: S.current.home,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.restaurant_menu),
              label: S.current.menuTab,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.person),
              label: S.current.profile,
            ),
            BottomNavigationBarItem(
              icon: const Icon(Icons.settings),
              label: S.current.setting,
            ),
          ],
        );
      },
    );
  }
}
