import 'package:dartantic_ai/dartantic_ai.dart';
import 'package:serverpod/serverpod.dart';

/// This is the endpoint that will be used to generate a recipe using the
/// Google Gemini API. It extends the Endpoint class and implements the
/// generateRecipe method.
class AiEndpoint extends Endpoint {
  /// Pass in a string containing the ingredients and get a recipe back.
  Future<String> askQuestion(Session session, String ingredients) async {
    // Serverpod automatically loads your passwords.yaml file and makes the passwords available
    // in the session.passwords map.
    final geminiApiKey = session.passwords['geminiApiKey'];
    if (geminiApiKey == null) {
      throw Exception('Gemini API key not found');
    }

    // Configure the Dartantic AI agent for Gemini before sending the prompt.
    Agent.environment['GEMINI_API_KEY'] = geminiApiKey;
    final agent = Agent.forProvider(
      Providers.google,
      chatModelName: 'gemini-2.5-flash-lite',
    );

    // final agent = Agent(
    //   geminiApiKey,
    // );

    // A prompt to generate a recipe, the user will provide a free text input with the ingredients.
    // final prompt =
    //     'Generate a recipe using the following ingredients: $ingredients. '
    //     'Always put the title of the recipe in the first line, and then the instructions. '
    //     'The recipe should be easy to follow and include all necessary steps. '
    //     'Please provide a detailed recipe.';

    final prompt =
        'explain this question in simple way $ingredients. '
        'Start with the title of the recipe on the first line, followed by details information. ';
    final response = await agent.send(prompt);

    final responseText = response.output;

    // Check if the response is empty.
    if (responseText.isEmpty) {
      throw Exception('No response from Gemini API');
    }

    return responseText;
  }
}
