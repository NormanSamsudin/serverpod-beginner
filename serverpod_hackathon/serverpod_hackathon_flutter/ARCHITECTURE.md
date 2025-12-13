# Flutter App Architecture

This Flutter app has been refactored to follow modern best practices with MVVM architecture, localization support, and navigation.

## ✅ Implemented Features

### 1. **Text Localization**
- **Location**: `lib/l10n/`
- Uses Flutter's built-in localization system with ARB files
- Currently supports English (can be extended to other languages)
- Configuration in `l10n.yaml`
- All UI strings are now localized using `AppLocalizations`

**Usage Example**:
```dart
final l10n = AppLocalizations.of(context)!;
Text(l10n.appTitle)
```

### 2. **MVVM Architecture**
The app follows a simplified MVVM pattern:

**ViewModels** (`lib/viewmodels/`):
- `RecipeViewModel` - Manages recipe generation logic
- `AuthViewModel` - Handles authentication state
- `GreetingViewModel` - Manages greeting/hello functionality
- Uses `ChangeNotifier` for state management
- Serverpod client handles data parsing, ViewModels manage business logic

**Views** (`lib/views/`):
- `screens/` - Full-page screens
  - `home_screen.dart` - Recipe generator (maintains original functionality)
  - `profile_screen.dart` - User profile and greeting
  - `settings_screen.dart` - App settings
  - `main_navigation_screen.dart` - Bottom navigation wrapper
- `widgets/` - Reusable UI components
  - `result_display.dart` - Displays results/errors

### 3. **Bottom Navigation with 3 Tabs**
- Home Tab - Recipe generator (original `MyHomePageState` functionality)
- Profile Tab - User authentication and greeting
- Settings Tab - App settings and preferences
- Implemented using `AutoTabsScaffold` from auto_route

### 4. **Auto Route Navigation**
- **Router**: `lib/router/app_router.dart`
- Type-safe navigation using auto_route package
- Declarative routing with annotations
- Auto-generated route configurations

**Navigation Structure**:
```
MainNavigationRoute
├── HomeRoute (Recipe Generator)
├── ProfileRoute (Auth & Greeting)
└── SettingsRoute (Settings)
```

## 📁 Project Structure

```
lib/
├── l10n/                       # Localization files
│   └── app_en.arb             # English translations
├── router/                     # Navigation configuration
│   ├── app_router.dart        # Route definitions
│   └── app_router.gr.dart     # Generated routes
├── viewmodels/                 # Business logic layer
│   ├── recipe_viewmodel.dart
│   ├── auth_viewmodel.dart
│   └── greeting_viewmodel.dart
├── views/                      # UI layer
│   ├── screens/               # Full-page screens
│   └── widgets/               # Reusable components
└── main.dart                   # App entry point with providers
```

## 🔧 Key Dependencies

```yaml
dependencies:
  flutter_localizations: sdk
  intl: any
  auto_route: ^9.2.2
  provider: ^6.1.2

dev_dependencies:
  auto_route_generator: ^9.0.0
  build_runner: ^2.4.13
```

## 🚀 Running the App

1. **Get dependencies**:
   ```bash
   flutter pub get
   ```

2. **Generate localization files**:
   ```bash
   flutter gen-l10n
   ```

3. **Generate routes**:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the app**:
   ```bash
   flutter run
   ```

## 📝 Adding New Features

### Adding a new screen:
1. Create screen in `lib/views/screens/`
2. Add `@RoutePage()` annotation
3. Add route to `app_router.dart`
4. Run `dart run build_runner build --delete-conflicting-outputs`

### Adding new ViewModel:
1. Create ViewModel extending `ChangeNotifier` in `lib/viewmodels/`
2. Add to MultiProvider in `main.dart`
3. Use with `context.watch<YourViewModel>()` in views

### Adding new localized strings:
1. Add entry to `lib/l10n/app_en.arb`
2. Run `flutter gen-l10n`
3. Use `AppLocalizations.of(context)!.yourNewString`

## 🎨 Design Decisions

- **MVVM kept simple**: Since Serverpod handles data serialization, ViewModels focus on business logic and state
- **Provider for state management**: Lightweight and well-integrated with Flutter
- **Auto Route**: Type-safe navigation with minimal boilerplate
- **Original functionality preserved**: The recipe generator (`MyHomePageState`) is now in `HomeScreen`
