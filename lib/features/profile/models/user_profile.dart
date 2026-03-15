import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile.freezed.dart';
part 'user_profile.g.dart';

@freezed
class UserProfile with _$UserProfile {
  const factory UserProfile({
    required String id,
    required String name,
    String? email,
    String? avatarUrl,
    required DateTime joinedDate,
    required AppSettings settings,
    required LearningPreferences learningPrefs,
  }) = _UserProfile;
  
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
}

@freezed
class AppSettings with _$AppSettings {
  const factory AppSettings({
    @Default('de') String language,
    @Default(false) bool darkMode,
    @Default(true) bool notificationsEnabled,
    @Default(true) bool dailyReminder,
    @Default('09:00') String reminderTime,
    @Default(true) bool soundEffects,
    @Default(true) bool hapticFeedback,
  }) = _AppSettings;
  
  factory AppSettings.fromJson(Map<String, dynamic> json) =>
      _$AppSettingsFromJson(json);
}

@freezed
class LearningPreferences with _$LearningPreferences {
  const factory LearningPreferences({
    @Default(20) int dailyGoal,
    @Default('A1') String currentLevel,
    @Default(true) bool autoPlayAudio,
    @Default(false) bool showTranscription,
    @Default('standard') String learningMode,
    @Default('uk') String nativeLanguage,
  }) = _LearningPreferences;
  
  factory LearningPreferences.fromJson(Map<String, dynamic> json) =>
      _$LearningPreferencesFromJson(json);
}
