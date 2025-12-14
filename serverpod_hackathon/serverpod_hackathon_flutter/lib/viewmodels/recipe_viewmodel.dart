import 'package:flutter/material.dart';
import 'package:serverpod_hackathon_client/serverpod_hackathon_client.dart';

/// ViewModel for the Recipe Generator screen
/// Handles business logic and state management for recipe generation
class RecipeViewModel extends ChangeNotifier {
  final Client _client;

  RecipeViewModel(this._client);

  String? _resultMessage;
  String? _errorMessage;
  bool _isLoading = false;

  String? get resultMessage => _resultMessage;
  String? get errorMessage => _errorMessage;
  bool get isLoading => _isLoading;

  /// Generates a recipe based on the provided ingredients
  Future<void> generateRecipe(String ingredients) async {
    if (ingredients.trim().isEmpty) {
      _errorMessage = 'Please enter some ingredients';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = null;
      _resultMessage = null;
      notifyListeners();

      final result = await _client.ai.askQuestion(ingredients);

      _resultMessage = result;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _resultMessage = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Chat with RAG (Retrieval-Augmented Generation) system
  Future<void> chatWithRAG(String message) async {
    if (message.trim().isEmpty) {
      _errorMessage = 'Please enter a message';
      notifyListeners();
      return;
    }

    try {
      _isLoading = true;
      _errorMessage = null;
      _resultMessage = null;
      notifyListeners();

      // Call the RAG endpoint for semantic search and AI-powered responses
      final result = await _client.rag.chat(message);

      _resultMessage = result;
      _errorMessage = null;
    } catch (e) {
      _errorMessage = e.toString();
      _resultMessage = null;
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  /// Clears the current state
  void clearState() {
    _resultMessage = null;
    _errorMessage = null;
    _isLoading = false;
    notifyListeners();
  }
}
