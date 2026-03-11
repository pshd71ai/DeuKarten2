import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';
import '../repositories/profile_repository.dart';

final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences must be overridden in main');
});

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final prefs = ref.watch(sharedPreferencesProvider);
  return ProfileRepositoryImpl(prefs);
});

final userProfileProvider = StateNotifierProvider<UserProfileNotifier, AsyncValue<UserProfile?>>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return UserProfileNotifier(repo);
});

final userStatisticsProvider = FutureProvider<UserStatistics>((ref) async {
  final repo = ref.watch(profileRepositoryProvider);
  return repo.getUserStatistics();
});

final aiTeacherSettingsProvider = StateNotifierProvider<AITeacherSettingsNotifier, AsyncValue<AITeacherSettings>>((ref) {
  final repo = ref.watch(profileRepositoryProvider);
  return AITeacherSettingsNotifier(repo);
});

class UserProfileNotifier extends StateNotifier<AsyncValue<UserProfile?>> {
  final ProfileRepository _repository;
  
  UserProfileNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadProfile();
  }
  
  Future<void> _loadProfile() async {
    try {
      final profile = await _repository.getUserProfile();
      state = AsyncValue.data(profile);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
  
  Future<void> createProfile({
    required String name,
    String? email,
  }) async {
    final newProfile = UserProfile(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      joinedDate: DateTime.now(),
      settings: const AppSettings(),
      learningPrefs: const LearningPreferences(),
    );
    
    await _repository.saveUserProfile(newProfile);
    state = AsyncValue.data(newProfile);
  }
  
  Future<void> updateProfile(UserProfile profile) async {
    await _repository.saveUserProfile(profile);
    state = AsyncValue.data(profile);
  }
  
  Future<void> updateName(String name) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updated = current.copyWith(name: name);
    await updateProfile(updated);
  }
  
  Future<void> updateSettings(AppSettings settings) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updated = current.copyWith(settings: settings);
    await updateProfile(updated);
  }
  
  Future<void> updateLearningPreferences(LearningPreferences prefs) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updated = current.copyWith(learningPrefs: prefs);
    await updateProfile(updated);
  }
  
  Future<void> setDailyGoal(int goal) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedPrefs = current.learningPrefs.copyWith(dailyGoal: goal);
    final updated = current.copyWith(learningPrefs: updatedPrefs);
    await updateProfile(updated);
  }
  
  Future<void> setCurrentLevel(String level) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedPrefs = current.learningPrefs.copyWith(currentLevel: level);
    final updated = current.copyWith(learningPrefs: updatedPrefs);
    await updateProfile(updated);
  }
  
  Future<void> setLearningMode(String mode) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedPrefs = current.learningPrefs.copyWith(learningMode: mode);
    final updated = current.copyWith(learningPrefs: updatedPrefs);
    await updateProfile(updated);
  }
  
  Future<void> setAutoPlayAudio(bool value) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedPrefs = current.learningPrefs.copyWith(autoPlayAudio: value);
    final updated = current.copyWith(learningPrefs: updatedPrefs);
    await updateProfile(updated);
  }
  
  Future<void> setShowTranscription(bool value) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedPrefs = current.learningPrefs.copyWith(showTranscription: value);
    final updated = current.copyWith(learningPrefs: updatedPrefs);
    await updateProfile(updated);
  }
  
  Future<void> setDarkMode(bool value) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedSettings = current.settings.copyWith(darkMode: value);
    final updated = current.copyWith(settings: updatedSettings);
    await updateProfile(updated);
  }
  
  Future<void> setNotificationsEnabled(bool value) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedSettings = current.settings.copyWith(notificationsEnabled: value);
    final updated = current.copyWith(settings: updatedSettings);
    await updateProfile(updated);
  }
  
  Future<void> setDailyReminder(bool value) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedSettings = current.settings.copyWith(dailyReminder: value);
    final updated = current.copyWith(settings: updatedSettings);
    await updateProfile(updated);
  }
  
  Future<void> setReminderTime(String time) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedSettings = current.settings.copyWith(reminderTime: time);
    final updated = current.copyWith(settings: updatedSettings);
    await updateProfile(updated);
  }
  
  Future<void> setLanguage(String language) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedSettings = current.settings.copyWith(language: language);
    final updated = current.copyWith(settings: updatedSettings);
    await updateProfile(updated);
  }
  
  Future<void> setSoundEffects(bool value) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedSettings = current.settings.copyWith(soundEffects: value);
    final updated = current.copyWith(settings: updatedSettings);
    await updateProfile(updated);
  }
  
  Future<void> setHapticFeedback(bool value) async {
    final current = state.valueOrNull;
    if (current == null) return;
    
    final updatedSettings = current.settings.copyWith(hapticFeedback: value);
    final updated = current.copyWith(settings: updatedSettings);
    await updateProfile(updated);
  }
  
  Future<void> clearAllData() async {
    await _repository.clearAllData();
    state = const AsyncValue.data(null);
  }
  
  Future<String> exportData() async {
    return _repository.exportUserData();
  }
  
  Future<void> importData(String jsonData) async {
    await _repository.importUserData(jsonData);
    await _loadProfile();
  }
}

class AITeacherSettingsNotifier extends StateNotifier<AsyncValue<AITeacherSettings>> {
  final ProfileRepository _repository;
  
  AITeacherSettingsNotifier(this._repository) : super(const AsyncValue.loading()) {
    _loadSettings();
  }
  
  Future<void> _loadSettings() async {
    try {
      // Try to load existing settings
      final prefs = await _repository.getUserProfile();
      if (prefs != null) {
        // Settings are stored in profile, return default if not found
        state = const AsyncValue.data(AITeacherSettings());
      } else {
        state = const AsyncValue.data(AITeacherSettings());
      }
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
  
  Future<void> setEnabled(bool value) async {
    final current = state.valueOrNull ?? const AITeacherSettings();
    final updated = current.copyWith(enabled: value);
    await _repository.updateAITeacherSettings(updated);
    state = AsyncValue.data(updated);
  }
  
  Future<void> setPersonality(String personality) async {
    final current = state.valueOrNull ?? const AITeacherSettings();
    final updated = current.copyWith(personality: personality);
    await _repository.updateAITeacherSettings(updated);
    state = AsyncValue.data(updated);
  }
  
  Future<void> setAutoExplainGrammar(bool value) async {
    final current = state.valueOrNull ?? const AITeacherSettings();
    final updated = current.copyWith(autoExplainGrammar: value);
    await _repository.updateAITeacherSettings(updated);
    state = AsyncValue.data(updated);
  }
  
  Future<void> setAutoCorrectSentences(bool value) async {
    final current = state.valueOrNull ?? const AITeacherSettings();
    final updated = current.copyWith(autoCorrectSentences: value);
    await _repository.updateAITeacherSettings(updated);
    state = AsyncValue.data(updated);
  }
  
  Future<void> setAutoSpeakResponses(bool value) async {
    final current = state.valueOrNull ?? const AITeacherSettings();
    final updated = current.copyWith(autoSpeakResponses: value);
    await _repository.updateAITeacherSettings(updated);
    state = AsyncValue.data(updated);
  }
  
  Future<void> setTtsSpeed(double speed) async {
    final current = state.valueOrNull ?? const AITeacherSettings();
    final updated = current.copyWith(ttsSpeed: speed);
    await _repository.updateAITeacherSettings(updated);
    state = AsyncValue.data(updated);
  }
  
  Future<void> setTtsVoice(String voice) async {
    final current = state.valueOrNull ?? const AITeacherSettings();
    final updated = current.copyWith(ttsVoice: voice);
    await _repository.updateAITeacherSettings(updated);
    state = AsyncValue.data(updated);
  }
  
  Future<void> setShowSuggestions(bool value) async {
    final current = state.valueOrNull ?? const AITeacherSettings();
    final updated = current.copyWith(showSuggestions: value);
    await _repository.updateAITeacherSettings(updated);
    state = AsyncValue.data(updated);
  }
  
  Future<void> setTrackMistakes(bool value) async {
    final current = state.valueOrNull ?? const AITeacherSettings();
    final updated = current.copyWith(trackMistakes: value);
    await _repository.updateAITeacherSettings(updated);
    state = AsyncValue.data(updated);
  }
}
