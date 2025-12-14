import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_hackathon_flutter/l10n/app_localizations.dart';
import 'package:serverpod_hackathon_flutter/router/app_router.dart';
import 'package:serverpod_hackathon_flutter/viewmodels/auth_viewmodel.dart';
import 'package:serverpod_hackathon_flutter/views/screens/base_screen.dart';

@RoutePage()
class ProfileScreen extends BaseScreen {
  const ProfileScreen({super.key});

  @override
  BaseScreenState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseScreenState<ProfileScreen> {
  @override
  Widget buildAppBarTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Text(l10n.profile);
  }

  @override
  EdgeInsets bodyPadding(BuildContext context) => const EdgeInsets.all(16);

  @override
  bool get useSafeArea => false;

  void _handleLogout() async {
    final authViewModel = context.read<AuthViewModel>();
    await authViewModel.signOut();

    if (mounted) {
      context.router.replaceAll([const LoginRoute()]);
    }
  }

  @override
  Widget buildBody(BuildContext context) {
    final authViewModel = context.watch<AuthViewModel>();
    final user = authViewModel.currentUser;

    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 24),

          // Profile Avatar
          CircleAvatar(
            radius: 60,
            backgroundColor: Theme.of(context).colorScheme.primaryContainer,
            child: Icon(
              Icons.person,
              size: 60,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
            ),
          ),
          const SizedBox(height: 24),

          // User Info Card
          Card(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _InfoRow(
                    icon: Icons.person_outline,
                    label: 'Name',
                    value: user?.displayName ?? 'Not set',
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.email_outlined,
                    label: 'Email',
                    value: user?.email ?? 'Not available',
                  ),
                  const Divider(),
                  _InfoRow(
                    icon: Icons.badge_outlined,
                    label: 'User ID',
                    value: user?.uid ?? 'Not available',
                  ),
                  if (user?.emailVerified == false) ...[
                    const Divider(),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Theme.of(context).colorScheme.errorContainer,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        children: [
                          Icon(
                            Icons.warning_outlined,
                            color: Theme.of(
                              context,
                            ).colorScheme.onErrorContainer,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            'Email not verified',
                            style: TextStyle(
                              color: Theme.of(
                                context,
                              ).colorScheme.onErrorContainer,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          // Logout Button
          SizedBox(
            width: double.infinity,
            child: FilledButton.tonalIcon(
              onPressed: _handleLogout,
              icon: const Icon(Icons.logout),
              label: const Text('Sign Out'),
              style: FilledButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(
            icon,
            color: Theme.of(context).colorScheme.primary,
            size: 24,
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
