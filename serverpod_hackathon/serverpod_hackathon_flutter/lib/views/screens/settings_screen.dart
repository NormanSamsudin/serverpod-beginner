import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_hackathon_flutter/l10n/app_localizations.dart';
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
    final l10n = AppLocalizations.of(context)!;
    return Text(l10n.settings);
  }

  @override
  bool get useSafeArea => false;

  @override
  Widget buildBody(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

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
          leading: const Icon(Icons.info_outline),
          title: const Text('About'),
          onTap: () {
            showAboutDialog(
              context: context,
              applicationName: l10n.appTitle,
              applicationVersion: '1.0.0',
            );
          },
        ),
      ],
    );
  }
}
