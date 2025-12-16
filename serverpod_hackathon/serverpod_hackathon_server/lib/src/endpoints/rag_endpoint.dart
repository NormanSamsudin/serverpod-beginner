import 'package:serverpod/serverpod.dart';
import 'package:serverpod_hackathon_server/src/generated/protocol.dart';
import '../services/embedding_service.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'dart:convert';

class RagEndpoint extends Endpoint {
  /// Chat with RAG - retrieves relevant menu items and generates response
  Future<String> chat(Session session, String userMessage) async {
    try {
      final apiKey = session.passwords['geminiApiKey'];
      if (apiKey == null || apiKey.isEmpty) {
        return 'Sorry, the AI service is not configured.';
      }

      final embeddingService = EmbeddingService(apiKey);

      // Step 1: Generate query embedding
      final queryEmbedding = await embeddingService.generateQueryEmbedding(
        userMessage,
      );

      // Step 2: Retrieve relevant menu items using vector similarity
      final relevantItems = await _retrieveRelevantItems(
        session,
        queryEmbedding,
        topK: 10,
      );

      if (relevantItems.isEmpty) {
        return 'I couldn\'t find any relevant menu items. Could you please be more specific about what you\'re looking for?';
      }

      // Step 3: Create context from retrieved items
      final context = _formatMenuContext(relevantItems);

      // Step 4: Generate response with RAG context
      final prompt =
          '''You are a helpful food court assistant. Based on the available menu items and the user's question, provide a friendly and informative response.

              Available Menu Items:
              $context

              User Question: $userMessage

              Instructions:
              - Recommend specific dishes from the menu above
              - Explain why each recommendation fits the user's needs
              - Include prices, dietary info (vegetarian/halal), and spicy levels
              - Be conversational and helpful
              - If the user asks about availability, refer to the items listed above
              ''';

      final model = GenerativeModel(
        model: 'gemini-1.5-flash',
        apiKey: apiKey,
      );

      final response = await model.generateContent([Content.text(prompt)]);
      return response.text ??
          'I\'m here to help! What would you like to know about our menu?';
    } catch (e) {
      session.log('RAG chat error: $e', level: LogLevel.error);
      return 'Sorry, I encountered an error. Please try again.';
    }
  }

  /// Generate and store embeddings for a menu item
  Future<void> generateMenuEmbedding(Session session, int menuItemId) async {
    try {
      final apiKey = session.passwords['geminiApiKey'];
      if (apiKey == null) {
        throw Exception('Gemini API key not found');
      }

      final embeddingService = EmbeddingService(apiKey);

      final item = await MenuItem.db.findById(session, menuItemId);
      if (item == null) {
        throw Exception('Menu item not found');
      }

      final text = EmbeddingService.createMenuItemText({
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
      });

      final embedding = await embeddingService.generateEmbedding(text);

      // Store embedding as JSON string
      item.embedding = jsonEncode(embedding);
      await MenuItem.db.updateRow(session, item);

      session.log('Generated embedding for: ${item.name}');
    } catch (e) {
      session.log('Error generating menu embedding: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Generate embeddings for all menu items
  Future<int> generateAllEmbeddings(Session session) async {
    try {
      final items = await MenuItem.db.find(session);
      int count = 0;

      for (final item in items) {
        await generateMenuEmbedding(session, item.id!);
        count++;

        // Add small delay to avoid rate limiting
        await Future.delayed(Duration(milliseconds: 100));
      }

      return count;
    } catch (e) {
      session.log('Error generating all embeddings: $e', level: LogLevel.error);
      rethrow;
    }
  }

  /// Retrieve menu items most similar to query embedding
  Future<List<MenuItem>> _retrieveRelevantItems(
    Session session,
    List<double> queryEmbedding, {
    int topK = 10,
  }) async {
    // Get all items with embeddings
    final allItems = await MenuItem.db.find(
      session,
      where: (t) => t.embedding.notEquals(null),
    );

    // Calculate similarity scores
    final scored = <({MenuItem item, double score})>[];

    for (final item in allItems) {
      if (item.embedding == null) continue;

      try {
        final itemEmbedding = (jsonDecode(item.embedding!) as List)
            .map((e) => (e as num).toDouble())
            .toList();

        final similarity = EmbeddingService.cosineSimilarity(
          queryEmbedding,
          itemEmbedding,
        );

        scored.add((item: item, score: similarity));
      } catch (e) {
        session.log('Error parsing embedding for ${item.name}: $e');
      }
    }

    // Sort by similarity score (highest first)
    scored.sort((a, b) => b.score.compareTo(a.score));

    // Return top K items
    return scored.take(topK).map((s) => s.item).toList();
  }

  /// Format menu items as context for LLM
  String _formatMenuContext(List<MenuItem> items) {
    return items
        .map((item) {
          final features = <String>[];
          if (item.isVegetarian) features.add('🌱 Vegetarian');
          if (item.isHalal) features.add('🕌 Halal');
          if (item.spicyLevel > 0)
            features.add('🌶️ Spicy Level: ${item.spicyLevel!}/5');

          return '''
• ${item.name} - RM${item.price.toStringAsFixed(2)}
  Restaurant: ${item.restaurantName}
  Cuisine: ${item.cuisine} | Category: ${item.category}
  ${features.isNotEmpty ? features.join(' | ') : ''}
  ${item.description}
''';
        })
        .join('\n');
  }
}
