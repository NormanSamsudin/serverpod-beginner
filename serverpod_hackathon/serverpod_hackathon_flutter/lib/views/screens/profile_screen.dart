import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:serverpod_hackathon_flutter/l10n/app_localizations.dart';
import 'package:serverpod_hackathon_flutter/viewmodels/greeting_viewmodel.dart';
import 'package:serverpod_hackathon_flutter/views/screens/base_screen.dart';
import 'package:serverpod_hackathon_flutter/views/widgets/result_display.dart';

@RoutePage()
class ProfileScreen extends BaseScreen {
  const ProfileScreen({super.key});

  @override
  BaseScreenState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends BaseScreenState<ProfileScreen> {
  final _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget buildAppBarTitle(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return Text(l10n.profile);
  }

  @override
  EdgeInsets bodyPadding(BuildContext context) => const EdgeInsets.all(16);

  @override
  bool get useSafeArea => false;

  @override
  Widget buildBody(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final greetingViewModel = context.watch<GreetingViewModel>();

    return Column(
      children: [
        Text(
          'Greeting Test',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        const SizedBox(height: 32),
        TextField(
          controller: _textEditingController,
          decoration: InputDecoration(
            hintText: l10n.enterYourName,
            border: const OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: greetingViewModel.isLoading
                ? null
                : () {
                    greetingViewModel.sendGreeting(
                      _textEditingController.text,
                    );
                  },
            child: Text(
              greetingViewModel.isLoading ? l10n.loading : l10n.sendToServer,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: SingleChildScrollView(
            child: ResultDisplay(
              resultMessage: greetingViewModel.resultMessage,
              errorMessage: greetingViewModel.errorMessage,
            ),
          ),
        ),
      ],
    );
  }
}
