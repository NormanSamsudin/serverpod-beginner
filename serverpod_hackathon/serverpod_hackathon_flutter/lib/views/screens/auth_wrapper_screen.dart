import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:serverpod_hackathon_flutter/router/app_router.dart';

@RoutePage()
class AuthWrapperScreen extends StatelessWidget {
  const AuthWrapperScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // User is logged in - navigate to main app
        if (snapshot.hasData && snapshot.data != null) {
          // Navigate to main navigation after first frame
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.router.replaceAll([const MainNavigationRoute()]);
          });
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        // User is not logged in - navigate to login
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.router.replaceAll([const LoginRoute()]);
        });
        return const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      },
    );
  }
}
