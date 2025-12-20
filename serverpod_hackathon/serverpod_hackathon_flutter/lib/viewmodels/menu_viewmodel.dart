import 'package:flutter/material.dart';
import 'package:serverpod_hackathon_client/serverpod_hackathon_client.dart';

/// ViewModel for the Menu screen
/// Handles business logic and state management for menu items
class MenuViewModel extends ChangeNotifier {
  final Client _client;

  MenuViewModel(this._client);

  List<MenuItem>? _menuItems;
  String? _errorMessage;
  bool _isLoading = false;

  List<MenuItem>? get menuItems => _menuItems;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  /// Fetches all menu items from the server
  Future<void> fetchMenuItems() async {
    try {
      _isLoading = true;
      _errorMessage = null;
      notifyListeners();

      final items = await _client.menu.getAllMenuItems();
      
      _menuItems = items;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _menuItems = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Refreshes the menu items (for pull-to-refresh)
  Future<void> refreshMenuItems() async {
    await fetchMenuItems();
  }

  /// Clears the current state
  void clearState() {
    _menuItems = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
