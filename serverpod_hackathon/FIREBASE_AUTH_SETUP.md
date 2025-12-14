# Firebase Authentication Setup Guide

## 🔥 Firebase Setup Complete!

Your app is now configured to use Firebase Authentication instead of Serverpod's built-in auth.

## What's Been Changed

### 1. **Dependencies Updated** ([pubspec.yaml](pubspec.yaml))
- ✅ Added `firebase_core: ^3.8.1`
- ✅ Added `firebase_auth: ^5.3.3`
- ✅ Added `flutter_secure_storage: ^9.2.4`
- ❌ Removed `serverpod_auth_idp_flutter`

### 2. **AuthViewModel Updated** ([lib/viewmodels/auth_viewmodel.dart](lib/viewmodels/auth_viewmodel.dart))
Now uses Firebase Authentication with:
- `register()` - Create account with Firebase
- `signIn()` - Sign in with Firebase
- `signOut()` - Sign out from Firebase
- `sendPasswordResetEmail()` - Password recovery
- Auto user state management

### 3. **Main App Updated** ([lib/main.dart](lib/main.dart))
- Firebase initialized before app starts
- Removed Serverpod SessionManager
- AuthViewModel no longer needs SessionManager

### 4. **Profile Screen Updated** ([lib/views/screens/profile_screen.dart](lib/views/screens/profile_screen.dart))
- Shows Firebase user data (displayName, email, uid)
- Shows email verification status

## 📝 Required Setup Steps

### Step 1: Install Dependencies

```bash
cd serverpod_hackathon_flutter
flutter pub get
```

### Step 2: Create Firebase Project

1. Go to [Firebase Console](https://console.firebase.google.com/)
2. Click "Add Project"
3. Enter project name (e.g., "serverpod-hackathon")
4. Disable Google Analytics (optional)
5. Click "Create Project"

### Step 3: Add Android App to Firebase

1. In Firebase Console, click the Android icon
2. Enter package name: `com.example.serverpod_hackathon_flutter`
   - Find this in: `android/app/build.gradle.kts` → `applicationId`
3. Click "Register app"
4. Download `google-services.json`
5. Place it in: `serverpod_hackathon_flutter/android/app/google-services.json`

### Step 4: Configure Android

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

### Step 5: Enable Email/Password Authentication

1. In Firebase Console → Authentication
2. Click "Get Started"
3. Click "Sign-in method" tab
4. Enable "Email/Password"
5. Click "Save"

### Step 6: Get Firebase Configuration

#### Option A: Use FlutterFire CLI (Recommended)

```bash
# Install FlutterFire CLI
dart pub global activate flutterfire_cli

# Configure Firebase
flutterfire configure
```

This will automatically generate `lib/firebase_options.dart` with your credentials.

#### Option B: Manual Configuration

1. Go to Firebase Console → Project Settings
2. Scroll to "Your apps" section
3. Click on your Android app
4. Copy the configuration values
5. Update `lib/firebase_options.dart` with your values:

```dart
static const FirebaseOptions android = FirebaseOptions(
  apiKey: 'AIza...',  // From Firebase Console
  appId: '1:123...',  // From Firebase Console
  messagingSenderId: '123456789',  // From Firebase Console
  projectId: 'your-project-id',
  storageBucket: 'your-project-id.appspot.com',
);
```

### Step 7: Test the App

```bash
flutter run -d emulator-5554
```

## 🎯 Features

✅ User Registration with email/password
✅ User Login
✅ User Logout  
✅ Password Reset via Email
✅ Error handling with user-friendly messages
✅ Loading states
✅ Auto session persistence
✅ Email verification status
✅ Modern Material Design 3 UI

## 🔐 Firebase Auth Flow

1. **Registration**: User enters name, email, password → Firebase creates account → User automatically signed in
2. **Login**: User enters email, password → Firebase validates → User signed in
3. **Session**: Firebase automatically maintains auth state across app restarts
4. **Logout**: User clicks logout → Firebase signs out → Redirected to login screen

## 🐛 Common Issues

### Issue: "google-services.json not found"
**Solution**: Make sure you downloaded and placed `google-services.json` in `android/app/` directory

### Issue: "Firebase not initialized"
**Solution**: Update `lib/firebase_options.dart` with your project's credentials

### Issue: Gradle build errors
**Solution**: Make sure you added the Google Services plugin to both gradle files

### Issue: "Email already in use"
**Solution**: Use a different email or sign in with the existing account

## 📱 Testing Locally

For development/testing, you can use:
- Email: `test@example.com`
- Password: `Test123!`

Create test accounts through the registration screen.

## 🔄 Migration from Serverpod Auth

The authentication is now completely handled by Firebase. Your login and register screens will work the same way, but now:
- User data is stored in Firebase
- No need for Serverpod auth database tables
- Sessions managed by Firebase SDK
- Can add social logins (Google, Apple, etc.) easily later

## 🚀 Next Steps (Optional)

1. **Add Social Logins**:
   - Google Sign-In
   - Apple Sign-In
   - Facebook Login

2. **Email Verification**:
   ```dart
   await user.sendEmailVerification();
   ```

3. **Phone Authentication**:
   - Enable in Firebase Console
   - Add phone number field to registration

4. **Custom Email Templates**:
   - Configure in Firebase Console → Authentication → Templates

## 📚 Resources

- [Firebase Auth Documentation](https://firebase.google.com/docs/auth/flutter/start)
- [FlutterFire Documentation](https://firebase.flutter.dev/)
- [Firebase Console](https://console.firebase.google.com/)
