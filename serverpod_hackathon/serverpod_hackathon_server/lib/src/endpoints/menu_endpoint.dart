import 'dart:convert';
import 'package:serverpod/serverpod.dart';
import 'package:serverpod_hackathon_server/src/generated/protocol.dart';
import '../services/embedding_service.dart';

class MenuEndpoint extends Endpoint {
  Future<bool> createMenuItem(Session session, MenuItem item) async {
    try {
      // Generate embedding if API key is available
      final apiKey = session.passwords['geminiApiKey'];
      if (apiKey != null && apiKey.isNotEmpty) {
        final embeddingService = EmbeddingService(apiKey);

        // Create text representation for embedding
        final itemMap = {
          'name': item.name,
          'description': item.description,
          'category': item.category,
          'cuisine': item.cuisine,
          'restaurantName': item.restaurantName,
          'isVegetarian': item.isVegetarian,
          'isHalal': item.isHalal,
          'spicyLevel': item.spicyLevel,
          'tags': item.tags,
          'price': item.price,
        };

        final text = EmbeddingService.createMenuItemText(itemMap);
        final embedding = await embeddingService.generateEmbedding(text);

        // Store embedding as JSON string
        item.embedding = jsonEncode(embedding);
      }

      await MenuItem.db.insertRow(session, item);
      return true;
    } catch (e) {
      session.log('Error creating menu item: $e', level: LogLevel.error);
      return false;
    }
  }

  Future<List<MenuItem>> getAllMenuItems(Session session) async {
    return await MenuItem.db.find(session, orderBy: (t) => t.name);
  }
}
