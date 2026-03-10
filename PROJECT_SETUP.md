# DeuKarten Project Setup

## Overview

DeuKarten is a German language learning mobile application built with Flutter, following clean architecture principles.

## Project Structure

```
lib/
 ├ core/
 │  ├ theme/                 # App theming system
 │  │  ├ app_colors.dart      # Color palette definition
 │  │  ├ app_typography.dart  # Typography system
 │  │  ├ app_theme.dart       # Material theme configuration
 │  │  └ theme.dart          # Theme exports
 │  ├ widgets/               # Reusable widgets
 │  │  ├ app_button.dart     # Custom button widget
 │  │  ├ app_card.dart       # Custom card widget
 │  │  ├ app_loading_indicator.dart
 │  │  └ widgets.dart        # Widget exports
 │  ├ constants/
 │  │  └ app_constants.dart  # App-wide constants
 │  └ core.dart             # Core module exports
 │
 ├ features/
 │  ├ cards/                # Flashcards feature
 │  │  ├ models/
 │  │  │  └ card_model.dart
 │  │  ├ providers/
 │  │  │  └ card_providers.dart
 │  │  ├ screens/
 │  │  │  ├ card_list_screen.dart
 │  │  │  ├ card_detail_screen.dart
 │  │  │  └ learning_screen.dart
 │  │  ├ widgets/
 │  │  │  └ flashcard_widget.dart
 │  │  └ cards.dart
 │  │
 │  ├ tests/                # Tests feature
 │  │  ├ models/
 │  │  │  ├ test_model.dart
 │  │  │  └ question_model.dart
 │  │  ├ providers/
 │  │  │  └ test_providers.dart
 │  │  ├ screens/
 │  │  │  ├ test_list_screen.dart
 │  │  │  ├ test_detail_screen.dart
 │  │  │  └ test_result_screen.dart
 │  │  └ tests.dart
 │  │
 │  ├ statistics/           # Statistics feature
 │  │  ├ models/
 │  │  │  └ statistics_model.dart
 │  │  ├ providers/
 │  │  │  └ statistics_providers.dart
 │  │  ├ screens/
 │  │  │  ├ statistics_screen.dart
 │  │  │  └ progress_screen.dart
 │  │  ├ widgets/
 │  │  │  ├ stat_card_widget.dart
 │  │  │  └ progress_chart_widget.dart
 │  │  └ statistics.dart
 │  │
 │  └ ki_teacher/           # AI Teacher feature
 │     ├ models/
 │     │  └ chat_message_model.dart
 │     ├ providers/
 │     │  └ ki_teacher_providers.dart
 │     ├ screens/
 │     │  ├ ki_teacher_screen.dart
 │     │  └ chat_screen.dart
 │     ├ widgets/
 │     │  └ teacher_avatar_widget.dart
 │     └ ki_teacher.dart
 │
 ├ screens/
 │  └ home_screen.dart      # Main home screen
 │
 └ main.dart               # App entry point with routing

```

## Technology Stack

### Core Framework
- **Flutter**: 3.0.0+
- **Dart**: SDK 3.0.0+

### Dependencies

#### Navigation
- `go_router: ^14.6.1` - Declarative routing

#### State Management
- `flutter_riverpod: ^2.6.1` - State management
- `hooks_riverpod: ^2.6.1` - Riverpod hooks
- `flutter_hooks: ^0.20.5` - Flutter hooks

#### UI & Animations
- `flutter_animate: ^4.5.0` - Animations
- `google_fonts: ^6.2.1` - Typography
- `lottie: ^3.1.2` - Lottie animations
- `intl: ^0.19.0` - Internationalization

#### Voice & Speech
- `speech_to_text: ^7.0.0` - Speech recognition
- `flutter_tts: ^4.0.2` - Text-to-speech

#### Local Storage
- `hive: ^2.2.3` - NoSQL database
- `hive_flutter: ^1.1.0` - Hive Flutter integration

#### Development Tools
- `flutter_lints: ^4.0.0` - Linting rules
- `hive_generator: ^2.0.1` - Hive code generation
- `build_runner: ^2.4.13` - Code generation

## Color System

### Primary Colors
- **Primary**: #2F5BFF (Blue)
- **Primary Dark**: #1E3FCC
- **Primary Light**: #7A9FFF

### Secondary Colors
- **Secondary**: #FFCC00 (Yellow)
- **Secondary Dark**: #CCA300
- **Secondary Light**: #FFE066

### Accent Colors
- **Accent**: #FF3B30 (Red)
- **Accent Dark**: #CC2820
- **Accent Light**: #FF6B63

### Background Colors
- **Background**: #F5F7FB (Light gray)
- **Surface**: #FFFFFF (White)
- **Cards**: #FFFFFF

### Text Colors
- **Primary**: #1A1A1A
- **Secondary**: #6B7280
- **Tertiary**: #9CA3AF

### Functional Colors
- **Success**: #10B981
- **Warning**: #F59E0B
- **Error**: #EF4444
- **Info**: #3B82F6

## Typography System

### Font Family
- **Primary**: Inter (via Google Fonts)

### Font Sizes
- **Display Large**: 28px
- **Display Medium**: 22px
- **Headline**: 18px
- **Body Large**: 18px
- **Body Medium**: 14px
- **Body Small**: 12px
- **Caption**: 12px
- **Button**: 14px

### Font Weights
- **Light**: 300
- **Regular**: 400
- **Medium**: 500
- **Semi Bold**: 600
- **Bold**: 700

## Architecture

### Clean Architecture Pattern

The project follows a clean architecture approach with separation of concerns:

1. **Core Layer**: Contains shared utilities, themes, constants, and reusable widgets
2. **Feature Layer**: Contains feature-specific implementations following a modular structure
3. **Screens Layer**: Contains high-level screen compositions

### Feature Module Structure

Each feature module contains:
- **models**: Data models and entities
- **providers**: Riverpod state management
- **screens**: Feature screens
- **widgets**: Feature-specific widgets
- **index.dart**: Feature exports

## Routing

The app uses `go_router` for navigation with the following routes:

- `/` - Home Screen
- `/cards` - Flashcards List
- `/tests` - Tests List
- `/statistics` - Statistics
- `/ki-teacher` - AI Teacher

## Getting Started

### Prerequisites

1. Install Flutter SDK (3.0.0 or higher)
2. Install Android Studio / Xcode for mobile development
3. Set up an emulator or physical device

### Installation

```bash
# Clone the repository
git clone <repository-url>

# Navigate to the project directory
cd deu_karten

# Install dependencies
flutter pub get

# Run the app
flutter run
```

### Building

```bash
# Build APK for Android
flutter build apk

# Build app bundle for Android
flutter build appbundle

# Build for iOS
flutter build ios
```

## Platform Configuration

### Android
- **Package Name**: `com.deukarten.deu_karten`
- **Minimum SDK**: 21
- **Target SDK**: 34
- **Compile SDK**: 34

### iOS
- **Bundle Identifier**: `com.deukarten.deuKarten`
- **Minimum iOS Version**: 12.0
- **Deployment Target**: 12.0+

## Permissions

### Android
- `RECORD_AUDIO` - For speech recognition
- `INTERNET` - For AI features

### iOS
- `NSMicrophoneUsageDescription` - Microphone access for voice input

## Next Steps

1. Implement actual data persistence with Hive
2. Add actual AI integration for the KI Teacher feature
3. Implement voice recognition and text-to-speech
4. Add comprehensive error handling
5. Implement unit and integration tests
6. Add analytics and crash reporting
7. Implement onboarding flow
8. Add dark mode support
9. Localize the app for multiple languages
10. Implement user authentication (if needed)

## Notes

- The project is set up but Flutter CLI is not available in the current environment
- All file structures and code are ready for development
- To run the app, ensure Flutter SDK is installed and use `flutter run`
- The project follows Flutter best practices and clean architecture principles
