import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_hackathon_flutter/generated/l10n.dart';
import 'package:serverpod_hackathon_flutter/router/app_router.dart';
import 'package:serverpod_hackathon_flutter/views/screens/base_screen.dart';

@RoutePage()
class SettingsScreen extends BaseScreen {
  const SettingsScreen({super.key});

  @override
  BaseScreenState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreenState<SettingsScreen> {
  @override
  Widget buildAppBarTitle(BuildContext context) {
    return Text(S.current.setting);
  }

  @override
  bool get useSafeArea => false;

  @override
  Widget buildBody(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: const Icon(Icons.language),
          title: const Text('Language'),
          subtitle: const Text('English'),
          onTap: () {
            // TODO: Implement language selection
          },
        ),
        ListTile(
          leading: const Icon(Icons.dark_mode),
          title: const Text('Dark Mode'),
          trailing: Switch(
            value: false,
            onChanged: (value) {
              // TODO: Implement theme switching
            },
          ),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.admin_panel_settings),
          title: const Text('Add Menu Item (Admin)'),
          onTap: () {
            context.router.push(const AddMenuRoute());
          },
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: S.current.menuAppRecomendation,
              applicationVersion: '1.0.0',
            );
          },
        ),
      ],
    );
  }
}
