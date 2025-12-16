import 'package:google_generative_ai/google_generative_ai.dart';

class EmbeddingService {
  final String apiKey;
  late final GenerativeModel _embeddingModel;

  EmbeddingService(this.apiKey) {
    _embeddingModel = GenerativeModel(
      model: 'text-embedding-004',
      apiKey: apiKey,
    );
  }

  /// Generate embedding for text using Google's embedding model
  Future<List<double>> generateEmbedding(String text) async {
    try {
      final content = Content.text(text);
      final result = await _embeddingModel.embedContent(
        content,
        taskType: TaskType.retrievalDocument,
      );

      return result.embedding.values.toList();
    } catch (e) {
      print('Error generating embedding: $e');
      rethrow;
    }
  }

  /// Generate query embedding (optimized for search)
  Future<List<double>> generateQueryEmbedding(String query) async {
    try {
      final content = Content.text(query);
      final result = await _embeddingModel.embedContent(
        content,
        taskType: TaskType.retrievalQuery,
      );

      return result.embedding.values.toList();
    } catch (e) {
      print('Error generating query embedding: $e');
      rethrow;
    }
  }

  /// Create searchable text from menu item for embedding
  static String createMenuItemText(Map<String, dynamic> item) {
    final parts = <String>[];

    parts.add('Name: ${item['name']}');
    if (item['description'] != null) {
      parts.add('Description: ${item['description']}');
    }
    parts.add('Category: ${item['category']}');
    parts.add('Cuisine: ${item['cuisine']}');
    parts.add('Restaurant: ${item['restaurantName']}');

    if (item['isVegetarian'] == true) parts.add('Vegetarian');
    if (item['isHalal'] == true) parts.add('Halal');
    if (item['spicyLevel'] != null && item['spicyLevel'] > 0) {
      parts.add('Spicy level ${item['spicyLevel']}');
    }
    if (item['tags'] != null) {
      parts.add('Tags: ${item['tags']}');
    }
    parts.add('Price: RM${item['price']}');

    return parts.join('. ');
  }

  /// Calculate cosine similarity between two vectors
  static double cosineSimilarity(List<double> a, List<double> b) {
    if (a.length != b.length) {
      throw ArgumentError('Vectors must have same length');
    }

    double dotProduct = 0.0;
    double normA = 0.0;
    double normB = 0.0;

    for (int i = 0; i < a.length; i++) {
      dotProduct += a[i] * b[i];
      normA += a[i] * a[i];
      normB += b[i] * b[i];
    }

    return dotProduct / (sqrt(normA) * sqrt(normB));
  }

  static double sqrt(double x) => x < 0 ? 0 : _sqrt(x);

  static double _sqrt(double x) {
    if (x == 0) return 0;
    double guess = x / 2;
    for (int i = 0; i < 10; i++) {
      guess = (guess + x / guess) / 2;
    }
    return guess;
  }
}
