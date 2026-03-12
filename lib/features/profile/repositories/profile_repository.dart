import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

abstract class ProfileRepository {
  Future<UserProfile?> getUserProfile();
  Future<void> saveUserProfile(UserProfile profile);
  Future<UserStatistics> getUserStatistics();
  Future<void> updateSettings(AppSettings settings);
  Future<void> updateLearningPreferences(LearningPreferences prefs);
  Future<void> updateAITeacherSettings(AITeacherSettings settings);
  Future<String> exportUserData();
  Future<void> importUserData(String jsonData);
  Future<void> clearAllData();
}

class ProfileRepositoryImpl implements ProfileRepository {
  final SharedPreferences _prefs;
  
  static const String _keyUserProfile = 'user_profile';
  static const String _keyAiTeacherSettings = 'ai_teacher_settings';
  static const String _keyDailyStats = 'daily_stats';
  static const String _keyOverallStats = 'overall_stats';
  static const String _keyXp = 'user_xp';
  static const String _keyCardProgress = 'card_progress';
  static const String _keySessionHistory = 'session_history';
  
  ProfileRepositoryImpl(this._prefs);
  
  @override
  Future<UserProfile?> getUserProfile() async {
    final json = _prefs.getString(_keyUserProfile);
    if (json == null) return null;
    return UserProfile.fromJson(jsonDecode(json));
  }
  
  @override
  Future<void> saveUserProfile(UserProfile profile) async {
    await _prefs.setString(_keyUserProfile, jsonEncode(profile.toJson()));
  }
  
  @override
  Future<UserStatistics> getUserStatistics() async {
    final overallStats = _prefs.getString(_keyOverallStats);
    final dailyStatsJson = _prefs.getString(_keyDailyStats);
    final xp = _prefs.getInt(_keyXp) ?? 0;
    final cardProgressJson = _prefs.getString(_keyCardProgress);
    
    int totalCardsLearned = 0;
    int totalSessionsCompleted = 0;
    int totalStudyTimeMinutes = 0;
    int currentStreak = 0;
    int longestStreak = 0;
    double averageAccuracy = 0.0;
    List<DailyActivity> last30Days = [];
    Map<String, int> cardsByLevel = {};
    Map<String, int> weakAreas = {};
    
    // Parse daily stats
    if (dailyStatsJson != null) {
      final dailyStats = jsonDecode(dailyStatsJson) as List;
      last30Days = dailyStats.map((e) => DailyActivity.fromJson(e)).toList();
      
      // Calculate totals from daily stats
      for (final day in last30Days) {
        totalCardsLearned += day.cardsStudied;
        totalStudyTimeMinutes += day.studyTimeMinutes;
        if (day.cardsStudied > 0) {
          totalSessionsCompleted++;
        }
      }
      
      // Calculate average accuracy
      if (last30Days.isNotEmpty) {
        final totalAccuracy = last30Days.fold<double>(0, (sum, day) => sum + day.accuracy);
        averageAccuracy = totalAccuracy / last30Days.length;
      }
      
      // Calculate current streak
      currentStreak = _calculateCurrentStreak(last30Days);
      longestStreak = _calculateLongestStreak(last30Days);
    }
    
    // Parse card progress for level breakdown
    if (cardProgressJson != null) {
      final cardProgress = jsonDecode(cardProgressJson) as Map<String, dynamic>;
      final levelCounts = <String, int>{};
      
      cardProgress.forEach((cardId, progress) {
        if (progress is Map) {
          final level = progress['level']?.toString() ?? 'A1';
          levelCounts[level] = (levelCounts[level] ?? 0) + 1;
          if ((progress['successRate'] ?? 0.0) < 0.5) {
            final area = progress['category']?.toString() ?? 'Unknown';
            weakAreas[area] = (weakAreas[area] ?? 0) + 1;
          }
        }
      });
      
      cardsByLevel = levelCounts;
    }
    
    // Calculate current level from XP
    final currentLevel = _calculateLevel(xp);
    
    return UserStatistics(
      totalCardsLearned: totalCardsLearned,
      totalSessionsCompleted: totalSessionsCompleted,
      totalStudyTimeMinutes: totalStudyTimeMinutes,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      averageAccuracy: averageAccuracy,
      totalXp: xp,
      currentLevel: currentLevel,
      last30Days: last30Days,
      cardsByLevel: cardsByLevel,
      weakAreas: weakAreas,
    );
  }
  
  int _calculateLevel(int xp) {
    // Simple level calculation: every 500 XP = 1 level
    return (xp / 500).floor() + 1;
  }
  
  int _calculateCurrentStreak(List<DailyActivity> days) {
    if (days.isEmpty) return 0;
    
    final sortedDays = List<DailyActivity>.from(days)
      ..sort((a, b) => b.date.compareTo(a.date));
    
    int streak = 0;
    DateTime expectedDate = DateTime.now();
    
    for (final day in sortedDays) {
      final dayDate = DateTime(day.date.year, day.date.month, day.date.day);
      final expDate = DateTime(expectedDate.year, expectedDate.month, expectedDate.day);
      
      if (dayDate == expDate || dayDate == expDate.subtract(const Duration(days: 1))) {
        if (day.cardsStudied > 0) {
          streak++;
          expectedDate = dayDate;
        }
      } else {
        break;
      }
    }
    
    return streak;
  }
  
  int _calculateLongestStreak(List<DailyActivity> days) {
    if (days.isEmpty) return 0;
    
    final sortedDays = List<DailyActivity>.from(days)
      ..sort((a, b) => a.date.compareTo(b.date));
    
    int longestStreak = 0;
    int currentStreak = 0;
    DateTime? lastDate;
    
    for (final day in sortedDays) {
      if (day.cardsStudied == 0) {
        currentStreak = 0;
        lastDate = null;
        continue;
      }
      
      if (lastDate == null || day.date.difference(lastDate).inDays == 1) {
        currentStreak++;
      } else {
        currentStreak = 1;
      }
      
      if (currentStreak > longestStreak) {
        longestStreak = currentStreak;
      }
      
      lastDate = day.date;
    }
    
    return longestStreak;
  }
  
  @override
  Future<void> updateSettings(AppSettings settings) async {
    final currentProfile = await getUserProfile();
    if (currentProfile != null) {
      final updated = currentProfile.copyWith(settings: settings);
      await saveUserProfile(updated);
    }
  }
  
  @override
  Future<void> updateLearningPreferences(LearningPreferences prefs) async {
    final currentProfile = await getUserProfile();
    if (currentProfile != null) {
      final updated = currentProfile.copyWith(learningPrefs: prefs);
      await saveUserProfile(updated);
    }
  }
  
  @override
  Future<void> updateAITeacherSettings(AITeacherSettings settings) async {
    await _prefs.setString(_keyAiTeacherSettings, jsonEncode(settings.toJson()));
  }
  
  @override
  Future<String> exportUserData() async {
    final profile = await getUserProfile();
    final statistics = await getUserStatistics();
    final aiSettingsJson = _prefs.getString(_keyAiTeacherSettings);
    final cardProgress = _prefs.getString(_keyCardProgress);
    final sessionHistory = _prefs.getString(_keySessionHistory);
    
    final exportData = {
      'version': '1.0.0',
      'exportDate': DateTime.now().toIso8601String(),
      'profile': profile?.toJson(),
      'statistics': {
        'totalCardsLearned': statistics.totalCardsLearned,
        'totalSessionsCompleted': statistics.totalSessionsCompleted,
        'totalStudyTimeMinutes': statistics.totalStudyTimeMinutes,
        'currentStreak': statistics.currentStreak,
        'longestStreak': statistics.longestStreak,
        'averageAccuracy': statistics.averageAccuracy,
        'totalXp': statistics.totalXp,
        'currentLevel': statistics.currentLevel,
      },
      'aiTeacherSettings': aiSettingsJson != null ? jsonDecode(aiSettingsJson) : null,
      'cards': cardProgress != null ? jsonDecode(cardProgress) : [],
      'sessions': sessionHistory != null ? jsonDecode(sessionHistory) : [],
    };
    
    return const JsonEncoder.withIndent('  ').convert(exportData);
  }
  
  @override
  Future<void> importUserData(String jsonData) async {
    try {
      final data = jsonDecode(jsonData) as Map<String, dynamic>;
      
      // Validate version
      final version = data['version'] as String?;
      if (version == null) {
        throw FormatException('Invalid export file: missing version');
      }
      
      // Import profile
      if (data['profile'] != null) {
        final profile = UserProfile.fromJson(data['profile'] as Map<String, dynamic>);
        await saveUserProfile(profile);
      }
      
      // Import AI teacher settings
      if (data['aiTeacherSettings'] != null) {
        await _prefs.setString(
          _keyAiTeacherSettings,
          jsonEncode(data['aiTeacherSettings']),
        );
      }
      
      // Import card progress
      if (data['cards'] != null) {
        await _prefs.setString(_keyCardProgress, jsonEncode(data['cards']));
      }
      
      // Import session history
      if (data['sessions'] != null) {
        await _prefs.setString(_keySessionHistory, jsonEncode(data['sessions']));
      }
    } catch (e) {
      throw FormatException('Failed to import data: $e');
    }
  }
  
  @override
  Future<void> clearAllData() async {
    await _prefs.clear();
  }
  
  Future<List<Map<String, dynamic>>> _getSessionHistory() async {
    final json = _prefs.getString(_keySessionHistory);
    if (json == null) return [];
    final list = jsonDecode(json) as List;
    return list.cast<Map<String, dynamic>>();
  }
  
  Future<Map<String, dynamic>> _getAllCardProgress() async {
    final json = _prefs.getString(_keyCardProgress);
    if (json == null) return {};
    return jsonDecode(json) as Map<String, dynamic>;
  }
  
  Future<int> _getTotalCardsLearned() async {
    final stats = _prefs.getString(_keyOverallStats);
    if (stats != null) {
      final data = jsonDecode(stats) as Map<String, dynamic>;
      return data['totalCardsLearned'] as int? ?? 0;
    }
    return 0;
  }
  
  Future<int> _getTotalSessions() async {
    final stats = _prefs.getString(_keyOverallStats);
    if (stats != null) {
      final data = jsonDecode(stats) as Map<String, dynamic>;
      return data['totalSessionsCompleted'] as int? ?? 0;
    }
    return 0;
  }
}
