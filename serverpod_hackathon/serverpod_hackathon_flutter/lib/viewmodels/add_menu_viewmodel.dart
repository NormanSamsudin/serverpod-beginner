import 'package:flutter/material.dart';
import 'package:serverpod_hackathon_client/serverpod_hackathon_client.dart';

/// ViewModel for the Add Menu screen
/// Handles business logic and state management for creating menu items
class AddMenuViewModel extends ChangeNotifier {
  final Client _client;

  AddMenuViewModel(this._client);

  String? _errorMessage;
  String? _successMessage;
  bool _isLoading = false;

  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  bool get isLoading => _isLoading;

  /// Creates a new menu item
  Future<bool> createMenuItem({
    required String restaurantName,
    required String name,
    required String description,
    required double price,
    required String category,
    required String cuisine,
    required bool isVegetarian,
    required bool isHalal,
    required int spicyLevel,
  }) async {
    try {
      _isLoading = true;
      _errorMessage = null;
      _successMessage = null;
      notifyListeners();

      final newItem = MenuItem(
        restaurantName: restaurantName,
        name: name,
        description: description,
        price: price,
        category: category,
        cuisine: cuisine,
        isVegetarian: isVegetarian,
        isHalal: isHalal,
        spicyLevel: spicyLevel,
      );

      await _client.menu.createMenuItem(newItem);

      _successMessage = 'Menu item added successfully!';
      _errorMessage = null;
      return true;
    } catch (e) {
      _errorMessage = 'Error adding menu item: ${e.toString()}';
      _successMessage = null;
      return false;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clears the current state
  void clearState() {
    _errorMessage = null;
    _successMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
