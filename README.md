# Food Court RAG Assistant

A full-stack Dart application using Serverpod backend and Flutter frontend with AI-powered food recommendations using **RAG (Retrieval-Augmented Generation)**, Google Gemini embeddings, and Firebase Authentication.

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

### 4. Initialize RAG (First-time Setup)

After starting the server, you need to populate the menu and generate embeddings:

```bash
# In the Flutter app or using Serverpod Insights:

# 1. Seed menu data (15 sample food court items)
await client.menuSeed.seedMenuData();

# 2. Generate embeddings for all menu items
# This converts each dish to a 768-dimensional vector
# Takes ~2-3 minutes depending on number of items
await client.rag.generateAllEmbeddings();

# Now you can start chatting!
```

**What the embeddings do:**
- Convert menu items into numerical vectors that capture meaning
- Enable semantic search (e.g., "spicy" finds dishes with high spice levels)
- Allow AI to recommend actual menu items with accurate details

## 📱 Features

### 🤖 RAG (Retrieval-Augmented Generation)

The app uses advanced RAG technology to provide intelligent food recommendations:

**What is RAG?**
- **Retrieval**: Searches your food court menu database using semantic similarity
- **Augmented**: Adds relevant menu items as context to the AI
- **Generation**: AI creates personalized responses based on actual menu data

**How It Works:**

1. **Setup Phase (One-time)**
   - Menu items are stored in PostgreSQL database
   - Each item is converted to a 768-dimensional vector embedding using Google's `text-embedding-004` model
   - Embeddings capture the "meaning" of each dish (cuisine, ingredients, dietary info, price, etc.)

2. **Chat Phase (Every message)**
   ```
   User: "I want something spicy and cheap"
   ↓
   1. Convert query to vector embedding
   ↓
   2. Calculate cosine similarity with all menu items
   ↓
   3. Retrieve top 10 most relevant dishes
      (e.g., Mee Goreng 0.92, Nasi Lemak 0.87, Rendang 0.85)
   ↓
   4. Format retrieved items as context
   ↓
   5. Send to Gemini 1.5 Flash with context
   ↓
   6. AI generates personalized recommendation
   ↓
   "Try Mee Goreng for RM6.50 - our spiciest dish at level 4/5!"
   ```

**Why RAG vs Regular AI?**
- ❌ **Without RAG**: AI guesses menu items, may be inaccurate
- ✅ **With RAG**: AI recommends actual menu items with real prices and details

**Example Queries:**
- "Show me vegetarian options under RM8"
- "What halal Chinese dishes do you have?"
- "I want something healthy for lunch"
- "Give me your spiciest dish"

### Backend (Serverpod)
- **RAG Chat Endpoint** - Semantic search + AI-powered responses
- **Vector Embeddings** - Google Gemini text-embedding-004
- **Menu Management** - CRUD operations for food court items
- **Similarity Search** - Cosine similarity for finding relevant dishes
- **PostgreSQL Database** - Stores menu items with vector embeddings
- **Redis Cache** - For session management

### Frontend (Flutter)
- **Chatbot UI** - Modern chat interface for food recommendations
- **Firebase Authentication** - Email/password authentication with auto-routing
- **MVVM Architecture** - Clean separation of concerns with ViewModels
- **Auto Route Navigation** - Type-safe routing with auth guards
- **Base Screen Pattern** - Reusable screen structure for consistency
- **Bottom Navigation** - 3 tabs (Home, Profile, Settings)
- **Localization Support** - i18n ready with ARB files
- **State Management** - Using Provider

## 📁 Project Structure

```
serverpod_hackathon/
├── serverpod_hackathon_server/    # Backend server
│   ├── lib/src/
│   │   ├── endpoints/
│   │   │   ├── rag_endpoint.dart          # RAG chat + embeddings
│   │   │   ├── menu_seed_endpoint.dart    # Seed sample menu data
│   │   │   └── ai_endpoint.dart           # Basic AI endpoint
│   │   ├── services/
│   │   │   └── embedding_service.dart     # Google Gemini embeddings
│   │   └── protocol/
│   │       └── menu_item.yaml            # Menu item schema
│   ├── config/                           # Server configuration
│   └── docker-compose.yaml               # Database setup
│
├── serverpod_hackathon_flutter/   # Flutter app
│   ├── lib/
│   │   ├── viewmodels/           # Business logic
│   │   │   ├── auth_viewmodel.dart       # Firebase auth
│   │   │   ├── recipe_viewmodel.dart     # RAG chat logic
│   │   │   └── greeting_viewmodel.dart   # Greeting logic
│   │   ├── views/                # UI screens & widgets
│   │   │   └── screens/
│   │   │       ├── base_screen.dart          # Base screen pattern
│   │   │       ├── auth_wrapper_screen.dart  # Auth routing
│   │   │       ├── login_screen.dart         # Login UI
│   │   │       ├── register_screen.dart      # Registration UI
│   │   │       ├── home_screen.dart          # Food court chatbot
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
- **PostgreSQL 16** - Database for menu items and embeddings
- **Redis 6.2** - Cache and session store
- **Google Gemini API** - Text embeddings (text-embedding-004) & chat (gemini-1.5-flash)

### Frontend
- **Flutter 3.32** - Cross-platform UI framework
- **Firebase Auth** - Authentication service
- **Provider** - State management
- **Auto Route** - Type-safe navigation
- **Flutter Intl** - Localization

### RAG Components
- **Vector Embeddings** - 768-dimensional semantic representations
- **Cosine Similarity** - Measures semantic relevance between query and menu items
- **Semantic Search** - Natural language understanding for food queries
- **Context Augmentation** - Retrieved menu items enhance AI responses

## 🚀 Next Steps (Optional Enhancements)

### RAG Enhancements
1. **Add More Menu Items**: Expand the food court database
2. **Image Embeddings**: Use multimodal embeddings for food photos
3. **User Preferences**: Learn from user favorites to personalize recommendations
4. **Dietary Filters**: Advanced filtering for allergies and dietary restrictions
5. **Price Range Search**: Budget-aware recommendations
6. **Real-time Availability**: Track which stalls are open/closed

### Authentication
1. **Add Social Logins**: Google Sign-In, Apple Sign-In
2. **Email Verification**: Send verification emails
3. **Phone Authentication**: SMS-based login
4. **Custom Email Templates**: Configure in Firebase Console

### Features
1. **Order History**: Track user's previous orders
2. **Favorites**: Save favorite dishes
3. **Ratings & Reviews**: User feedback on dishes
4. **Share Recommendations**: Share via social media
5. **Nutrition Info**: Calorie and nutrition tracking
6. **Push Notifications**: Daily deals and recommendations

### UI/UX
1. **Dark Mode**: Theme switching
2. **Food Images**: Display dish photos in chat
3. **Voice Input**: Speak your food preferences
4. **Multi-language**: Support multiple languages
5. **Map View**: Show stall locations in food court

## 📖 Learn More

- [Serverpod Documentation](https://docs.serverpod.dev)
- [Flutter Documentation](https://docs.flutter.dev)
- [Firebase Auth Documentation](https://firebase.google.com/docs/auth/flutter/start)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Google Gemini API](https://ai.google.dev/gemini-api/docs)
- [RAG Introduction](https://aws.amazon.com/what-is/retrieval-augmented-generation/)
- [Understanding Vector Embeddings](https://developers.google.com/machine-learning/crash-course/embeddings/video-lecture)

## 🎓 How RAG Works - Technical Deep Dive

### Vector Embeddings Explained

**What are embeddings?**
- Numerical representations of text in 768-dimensional space
- Similar meanings = similar vectors
- Example: "spicy noodles" and "hot pasta" have nearby vectors

**Example embedding generation:**
```dart
// Menu item text
"Name: Mee Goreng. Description: Stir-fried yellow noodles with spicy sauce. 
 Category: Main Course. Cuisine: Malaysian. Halal. Spicy level 4. Price: RM6.50"

// Sent to Google text-embedding-004
↓
// Returns 768 numbers representing meaning
[0.23, -0.45, 0.12, 0.67, -0.34, ... 763 more numbers]
```

### Cosine Similarity

Measures how similar two vectors are (range: -1 to 1):
```
similarity = dot(A, B) / (||A|| × ||B||)

User query:     [0.15, -0.38, 0.27, ...]
Mee Goreng:     [0.18, -0.42, 0.20, ...]
Similarity:     0.92 (very similar!)

Chicken Rice:   [0.05, -0.10, 0.15, ...]
Similarity:     0.35 (less relevant)
```

### Complete RAG Pipeline

```
1. USER QUERY
   "I want something spicy and cheap"

2. EMBEDDING GENERATION
   Query → [0.15, -0.38, 0.27, ...] (768 dimensions)

3. SIMILARITY SEARCH
   Compare with all menu item embeddings:
   - Mee Goreng:    0.92 ⭐
   - Nasi Lemak:    0.87 ⭐
   - Rendang:       0.85 ⭐
   - Chicken Rice:  0.35
   - Palak Paneer:  0.42

4. RETRIEVE TOP ITEMS
   Top 10 most similar dishes retrieved

5. FORMAT CONTEXT
   • Mee Goreng - RM6.50
     Restaurant: Kopitiam Corner
     Cuisine: Malaysian | Category: Main Course
     🕌 Halal | 🌶️ Spicy Level: 4/5
     Stir-fried yellow noodles with spicy sauce...

6. AUGMENT AI PROMPT
   "You are a food court assistant. Based on these menu items:
    [Retrieved items]
    
    User Question: I want something spicy and cheap
    
    Provide personalized recommendations..."

7. GENERATE RESPONSE
   Gemini 1.5 Flash creates response using context:
   "Great choice! I recommend Mee Goreng for RM6.50 - it's 
    our spiciest dish at level 4/5 and super affordable!"

8. RETURN TO USER
   Display AI response in chat interface
```

### Database Schema

```yaml
menu_item:
  id: int (primary key)
  restaurantName: String      # "Wong's Kitchen"
  name: String                # "Char Kway Teow"
  description: String         # "Stir-fried rice noodles..."
  price: double               # 8.50
  category: String            # "Main Course"
  cuisine: String             # "Chinese"
  isVegetarian: bool          # false
  isHalal: bool               # true
  spicyLevel: int             # 3 (scale 0-5)
  allergens: String?          # "Shellfish, Soy"
  tags: String?               # "Popular, Recommended"
  imageUrl: String?           # URL to food photo
  embedding: String           # "[0.23, -0.45, 0.12, ...]"
```

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test thoroughly
5. Submit a pull request

## 📝 License

This project is open source and available under the MIT License.
