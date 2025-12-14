# Serverpod Recipe Generator

A full-stack Dart application using Serverpod backend and Flutter frontend with AI recipe generation powered by Google Gemini and Firebase Authentication.

## 🚀 Quick Start

### Prerequisites
- Docker Desktop (running)
- Dart SDK 3.10+
- Flutter 3.32+
- Firebase Account

### 1. Start the Server

```bash
# Navigate to server directory
cd serverpod_hackathon/serverpod_hackathon_server

# Start PostgreSQL and Redis
docker compose up -d

# Generate Serverpod code
serverpod generate

# Run migrations (first time only)
dart run bin/main.dart --apply-migrations

# Start the server
dart run bin/main.dart
```

Server will be available at `http://localhost:8080`

### 2. Set Up Firebase Authentication

Follow the Firebase setup steps in the [Firebase Authentication Setup](#-firebase-authentication-setup) section below.

### 3. Run the Flutter App

```bash
# Navigate to Flutter directory
cd serverpod_hackathon/serverpod_hackathon_flutter

# Get dependencies
flutter pub get

# Generate routes (first time only)
dart run build_runner build --delete-conflicting-outputs

# Run the app
flutter run
```

## 📱 Features

### Backend (Serverpod)
- **AI Recipe Generation** - Uses Google Gemini API to generate recipes from ingredients
- **Greeting Endpoint** - Simple hello world endpoint
- **PostgreSQL Database** - With migrations support
- **Redis Cache** - For session management

### Frontend (Flutter)
- **Firebase Authentication** - Email/password authentication with auto-routing
- **MVVM Architecture** - Clean separation of concerns with ViewModels
- **Auto Route Navigation** - Type-safe routing with auth guards
- **Chatbot UI** - Modern chat interface for recipe generation
- **Base Screen Pattern** - Reusable screen structure for consistency
- **Bottom Navigation** - 3 tabs (Home, Profile, Settings)
- **Localization Support** - i18n ready with ARB files
- **State Management** - Using Provider

## 📁 Project Structure

```
serverpod_hackathon/
├── serverpod_hackathon_server/    # Backend server
│   ├── lib/src/
│   │   ├── ai_endpoint.dart       # Recipe generation endpoint
│   │   └── greeting_endpoint.dart # Hello endpoint
│   ├── config/                    # Server configuration
│   └── docker-compose.yaml        # Database setup
│
├── serverpod_hackathon_flutter/   # Flutter app
│   ├── lib/
│   │   ├── viewmodels/           # Business logic
│   │   │   ├── auth_viewmodel.dart       # Firebase auth
│   │   │   ├── recipe_viewmodel.dart     # Recipe generation
│   │   │   └── greeting_viewmodel.dart   # Greeting logic
│   │   ├── views/                # UI screens & widgets
│   │   │   └── screens/
│   │   │       ├── base_screen.dart          # Base screen pattern
│   │   │       ├── auth_wrapper_screen.dart  # Auth routing
│   │   │       ├── login_screen.dart         # Login UI
│   │   │       ├── register_screen.dart      # Registration UI
│   │   │       ├── home_screen.dart          # Chatbot UI
│   │   │       ├── profile_screen.dart       # User profile
│   │   │       └── settings_screen.dart      # App settings
│   │   ├── router/               # Navigation
│   │   ├── l10n/                 # Translations
│   │   └── firebase_options.dart # Firebase config
│   └── pubspec.yaml
│
└── serverpod_hackathon_client/    # Generated client SDK
```

## 🔧 Configuration

### Set up Gemini API Key

Add your API key to `serverpod_hackathon_server/config/passwords.yaml`:

```yaml
development:
  geminiApiKey: 'your-gemini-api-key-here'
```

### Stop Services

```bash
# Stop server: Ctrl+C in terminal

# Stop Docker containers
cd serverpod_hackathon/serverpod_hackathon_server
docker compose stop
```

## 🔥 Firebase Authentication Setup

### What's Configured

Your app uses Firebase Authentication with:
- ✅ Email/password authentication
- ✅ Auto session persistence
- ✅ Auth state routing (login required)
- ✅ Password reset functionality
- ✅ User profile management

### Required Setup Steps

#### Step 1: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Enter project name (e.g., "serverpod-hackathon")
4. Disable Google Analytics (optional)
5. Click "Create Project"

#### Step 2: Add Android App to Firebase

1. In Firebase Console, click the Android icon
2. Enter package name: `com.example.serverpod_hackathon_flutter`
   - Find this in: `android/app/build.gradle.kts` → `applicationId`
3. Click "Register app"
4. Download `google-services.json`
5. Place it in: `serverpod_hackathon_flutter/android/app/google-services.json`

#### Step 3: Configure Android

Add to `android/build.gradle.kts`:

```kotlin
plugins {
    id("com.android.application") version "8.1.0" apply false
    id("com.google.gms.google-services") version "4.4.0" apply false  // ADD THIS
}
```

Add to `android/app/build.gradle.kts` at the bottom:

```kotlin
apply(plugin = "com.google.gms.google-services")  // ADD THIS LINE
```

#### Step 4: Enable Email/Password Authentication

1. In Firebase Console → Authentication
2. Click "Get Started"
3. Click "Sign-in method" tab
4. Enable "Email/Password"
5. Click "Save"

#### Step 5: Configure Firebase (Recommended Method)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Navigate to Flutter app
cd serverpod_hackathon_flutter

# Configure Firebase - this auto-generates firebase_options.dart
flutterfire configure
```

Select your Firebase project and the platforms you want to support.

#### Alternative: Manual Configuration

If you prefer manual setup:

1. Go to Firebase Console → Project Settings
2. Scroll to "Your apps" section
3. Click on your Android app
4. Copy the configuration values
5. Update `lib/firebase_options.dart` with your values

#### Step 6: Test the App

```bash
cd serverpod_hackathon_flutter
flutter run -d emulator-5554
```

### Authentication Flow

1. **App Launch**: 
   - Shows AuthWrapperScreen (loading)
   - Checks Firebase auth state
   - Routes to Login if not authenticated
   - Routes to Main App if authenticated

2. **Registration**: 
   - User enters name, email, password
   - Firebase creates account
   - User automatically signed in
   - Redirected to Main App

3. **Login**: 
   - User enters email, password
   - Firebase validates credentials
   - User signed in
   - Redirected to Main App

4. **Session Persistence**: 
   - Firebase maintains auth state
   - User stays logged in across app restarts
   - Auto-routing happens seamlessly

5. **Logout**: 
   - User clicks logout in Profile screen
   - Firebase signs out
   - Redirected to Login screen

### Common Firebase Issues

**Issue: "google-services.json not found"**
- Solution: Download from Firebase Console and place in `android/app/` directory

**Issue: "Firebase not initialized"**
- Solution: Run `flutterfire configure` or update `firebase_options.dart`

**Issue: Gradle build errors**
- Solution: Add Google Services plugin to both gradle files

**Issue: "Email already in use"**
- Solution: Use different email or sign in with existing account

## 🎨 UI Features

### Base Screen Pattern

All screens extend `BaseScreen` which provides:
- Overridable AppBar components
- FloatingActionButton support
- Drawer and BottomNavigationBar
- Background customization
- Padding and SafeArea control
- Body wrapping (e.g., keyboard dismissal)

Example usage:
```dart
@RoutePage()
class MyScreen extends BaseScreen {
  @override
  BaseScreenState<MyScreen> createState() => _MyScreenState();
}

class _MyScreenState extends BaseScreenState<MyScreen> {
  @override
  Widget buildAppBarTitle(BuildContext context) {
    return Text('My Screen');
  }

  @override
  Widget buildBody(BuildContext context) {
    return Center(child: Text('Content'));
  }
}
```

### Chatbot Interface

The Home screen features a modern chatbot UI:
- Message bubbles (user on right, bot on left)
- Avatars for user and bot
- Auto-scrolling to new messages
- Typing indicator while bot is thinking
- Error handling with red bubbles
- Empty state with helpful message

## 🛠️ Development Commands

### Server
```bash
# Generate code after protocol changes
serverpod generate

# Create new migration
dart run bin/main.dart --create-migration

# Apply migrations
dart run bin/main.dart --apply-migrations
```

### Flutter
```bash
# Generate routes after adding new screens
dart run build_runner build --delete-conflicting-outputs

# Generate localizations after updating ARB files
flutter gen-l10n

# Analyze code
flutter analyze

# Configure Firebase
flutterfire configure
```

## 📚 Tech Stack

### Backend
- **Serverpod 3.0** - Dart backend framework
- **PostgreSQL 16** - Database with pgvector
- **Redis 6.2** - Cache and session store
- **Google Gemini API** - AI recipe generation via dartantic_ai

### Frontend
- **Flutter 3.32** - Cross-platform UI framework
- **Firebase Auth** - Authentication service
- **Provider** - State management
- **Auto Route** - Type-safe navigation
- **Flutter Intl** - Localization

## 🚀 Next Steps (Optional Enhancements)

### Authentication
1. **Add Social Logins**: Google Sign-In, Apple Sign-In
2. **Email Verification**: Send verification emails
3. **Phone Authentication**: SMS-based login
4. **Custom Email Templates**: Configure in Firebase Console

### Features
1. **Recipe Favorites**: Save favorite recipes
2. **Recipe History**: View past generated recipes
3. **Share Recipes**: Share via social media
4. **Offline Support**: Cache recipes locally
5. **Push Notifications**: Recipe of the day

### UI/UX
1. **Dark Mode**: Theme switching
2. **Recipe Images**: AI-generated recipe images
3. **Voice Input**: Speak ingredients
4. **Recipe Categories**: Filter by cuisine type

## 📖 Learn More

- [Serverpod Documentation](https://docs.serverpod.dev)
- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase Auth Documentation](https://firebase.google.com/docs/auth/flutter/start)
- [FlutterFire Documentation](https://firebase.flutter.dev/)

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is open source and available under the MIT License.
