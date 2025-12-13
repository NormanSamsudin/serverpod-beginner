import 'package:flutter/material.dart';
import 'package:serverpod_hackathon_client/serverpod_hackathon_client.dart';

/// ViewModel for the Greeting feature
class GreetingViewModel extends ChangeNotifier {
  final Client _client;

  GreetingViewModel(this._client);

  String? _resultMessage;
  String? _errorMessage;
  bool _isLoading = false;

  String? get resultMessage => _resultMessage;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  /// Calls the greeting endpoint with the provided name
  Future<void> sendGreeting(String name) async {
    if (name.trim().isEmpty) {
      _errorMessage = 'Please enter your name';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = null;
      _resultMessage = null;
      notifyListeners();

      final result = await _client.greeting.hello(name);

      _resultMessage = result.message;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _resultMessage = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void clearState() {
    _resultMessage = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
