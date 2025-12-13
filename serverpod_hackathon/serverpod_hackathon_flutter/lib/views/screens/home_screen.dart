import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_hackathon_flutter/l10n/app_localizations.dart';
import 'package:serverpod_hackathon_flutter/viewmodels/recipe_viewmodel.dart';
import 'package:serverpod_hackathon_flutter/views/widgets/result_display.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final viewModel = context.watch<RecipeViewModel>();

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.recipeGenerator),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: TextField(
                controller: _textEditingController,
                decoration: InputDecoration(
                  hintText: l10n.enterIngredients,
                  border: const OutlineInputBorder(),
                ),
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: viewModel.isLoading
                      ? null
                      : () {
                          viewModel.generateRecipe(_textEditingController.text);
                        },
                  child: Text(
                    viewModel.isLoading ? l10n.loading : l10n.generateRecipe,
                  ),
                ),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: ResultDisplay(
                  resultMessage: viewModel.resultMessage,
                  errorMessage: viewModel.errorMessage,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
