class AppConstants {
  AppConstants._();

  // App Info
  static const String appName = 'DeuKarten';
  static const String appVersion = '1.0.0';

  // Storage Keys
  static const String keyOnboardingCompleted = 'onboarding_completed';
  static const String keyUserPreferences = 'user_preferences';
  static const String keyProgressData = 'progress_data';

  // Feature Keys
  static const String featureCards = 'cards';
  static const String featureTests = 'tests';
  static const String featureStatistics = 'statistics';
  static const String featureKiTeacher = 'ki_teacher';

  // Animation Durations
  static const int animationDurationShort = 200;
  static const int animationDurationMedium = 300;
  static const int animationDurationLong = 500;

  // Card Settings
  static const int defaultCardsPerSession = 10;
  static const int minCardsPerSession = 5;
  static const int maxCardsPerSession = 50;

  // Test Settings
  static const int defaultQuestionsPerTest = 20;
  static const int passingScore = 70;

  // Statistics
  static const int daysInWeek = 7;
  static const int daysInMonth = 30;

  // Navigation
  static const String routeHome = '/';
  static const String routeCards = '/cards';
  static const String routeTests = '/tests';
  static const String routeStatistics = '/statistics';
  static const String routeKiTeacher = '/ki_teacher';
}
