import 'package:flutter/material.dart';
import 'package:serverpod_hackathon_client/serverpod_hackathon_client.dart';

/// ViewModel for authentication and user profile
/// Note: This is a simplified version for future auth implementation
class AuthViewModel extends ChangeNotifier {
  final Client _client;

  AuthViewModel(this._client);

  // Placeholder for future authentication features
  bool get isAuthenticated => false;

  Future<void> signOut() async {
    // TODO: Implement signout when auth is configured
  }
}
