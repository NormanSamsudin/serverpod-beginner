import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_hackathon_flutter/l10n/app_localizations.dart';
import 'package:serverpod_hackathon_flutter/viewmodels/recipe_viewmodel.dart';
import 'package:serverpod_hackathon_flutter/views/screens/base_screen.dart';
import 'package:serverpod_hackathon_flutter/views/widgets/result_display.dart';

@RoutePage()
class HomeScreen extends BaseScreen {
  const HomeScreen({super.key});

  @override
  BaseScreenState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends BaseScreenState<HomeScreen> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget buildAppBarTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Text(l10n.recipeGenerator);
  }

  @override
  EdgeInsets bodyPadding(BuildContext context) => const EdgeInsets.all(16);

  @override
  bool get useSafeArea => false;

  @override
  Widget buildBody(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final viewModel = context.watch<RecipeViewModel>();

    return Column(
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
    );
  }
}
