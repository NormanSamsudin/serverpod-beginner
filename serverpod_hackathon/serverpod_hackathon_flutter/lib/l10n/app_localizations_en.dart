// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Serverpod Recipe';

  @override
  String get homeTab => 'Home';

  @override
  String get profileTab => 'Profile';

  @override
  String get settingsTab => 'Settings';

  @override
  String get enterIngredients => 'Enter your ingredients';

  @override
  String get generateRecipe => 'Generate Recipe';

  @override
  String get loading => 'Loading...';

  @override
  String get noResponseYet => 'No server response yet.';

  @override
  String get signIn => 'Sign In';

  @override
  String get signOut => 'Sign Out';

  @override
  String get youAreConnected => 'You are connected';

  @override
  String get enterYourName => 'Enter your name';

  @override
  String get sendToServer => 'Send to Server';

  @override
  String get recipeGenerator => 'Recipe Generator';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';
}
