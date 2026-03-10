# DeuKarten

A German language learning mobile app built with Flutter.

## Features

- **Flashcards**: Learn German vocabulary with interactive flashcards
- **Tests**: Assess your progress with quizzes and tests
- **Statistics**: Track your learning journey with detailed statistics
- **AI Teacher**: Practice conversation with an AI-powered language assistant

## Getting Started

### Prerequisites

- Flutter SDK (3.0.0 or higher)
- Dart SDK
- Android Studio / Xcode for mobile development

### Installation

1. Clone the repository
2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

## Project Structure

```
lib/
 ├ core/
 │  ├ theme/         (app_colors, app_typography, app_theme)
 │  ├ widgets/       (common reusable widgets)
 │  └ constants/     (app_constants)
 │
 ├ features/
 │  ├ cards/         (flashcards feature)
 │  ├ tests/         (tests feature)
 │  ├ statistics/    (stats feature)
 │  └ ki_teacher/    (AI teacher feature)
 │
 ├ screens/          (main screens)
 └ main.dart
```

## Dependencies

- **go_router**: Navigation
- **flutter_riverpod**: State management
- **flutter_animate**: Animations
- **google_fonts**: Typography
- **lottie**: Animations
- **speech_to_text**: Voice input
- **flutter_tts**: Text-to-speech
- **hive**: Local storage

## License

[Add your license here]
