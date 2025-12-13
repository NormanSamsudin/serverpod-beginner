# Serverpod Recipe Generator

A full-stack Dart application using Serverpod backend and Flutter frontend with AI recipe generation powered by Google Gemini.

## 🚀 Quick Start

### Prerequisites
- Docker Desktop (running)
- Dart SDK 3.10+
- Flutter 3.32+

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

### 2. Run the Flutter App

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
- **MVVM Architecture** - Clean separation of concerns with ViewModels
- **Auto Route Navigation** - Type-safe routing
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
│   │   ├── views/                # UI screens & widgets
│   │   ├── router/               # Navigation
│   │   └── l10n/                 # Translations
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
```

## 📚 Tech Stack

- **Backend**: Serverpod 3.0, Dart 3.10
- **Frontend**: Flutter 3.32
- **Database**: PostgreSQL 16 with pgvector
- **Cache**: Redis 6.2
- **AI**: Google Gemini API via dartantic_ai
- **State Management**: Provider
- **Navigation**: Auto Route
- **Localization**: Flutter Intl

## 📖 Learn More

- [Serverpod Documentation](https://docs.serverpod.dev)
- [Flutter Documentation](https://docs.flutter.dev)
