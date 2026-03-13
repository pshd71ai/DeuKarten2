import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/card_progress.dart';
import '../models/study_schedule.dart';
import '../services/spaced_repetition_service.dart';

abstract class ProgressRepository {
  Future<CardProgress?> getCardProgress(String cardId);
  Future<void> saveCardProgress(CardProgress progress);
  Future<void> saveAllProgress(Map<String, CardProgress> progress);
  Future<Map<String, CardProgress>> getAllProgress();
  Future<List<String>> getDueCards(DateTime date);
  Future<StudySchedule> getScheduleForDate(DateTime date);
  Future<void> saveSchedule(StudySchedule schedule);
  Future<DailyStats?> getDailyStats(DateTime date);
  Future<void> saveDailyStats(DailyStats stats);
  Future<List<DailyStats>> getLast30DaysStats();
  Future<void> resetAllProgress();
}

class ProgressRepositoryImpl implements ProgressRepository {
  final SharedPreferences _prefs;
  
  ProgressRepositoryImpl(this._prefs);
  
  @override
  Future<CardProgress?> getCardProgress(String cardId) async {
    final key = 'progress_$cardId';
    final json = _prefs.getString(key);
    if (json == null) return null;
    
    return CardProgress.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }
  
  @override
  Future<void> saveCardProgress(CardProgress progress) async {
    final key = 'progress_${progress.cardId}';
    await _prefs.setString(key, jsonEncode(progress.toJson()));
  }
  
  @override
  Future<Map<String, CardProgress>> getAllProgress() async {
    final Map<String, CardProgress> progress = {};
    
    // SharedPreferences approach
    final keys = _prefs.getKeys().where((k) => k.startsWith('progress_'));
    for (final key in keys) {
      final cardId = key.replaceFirst('progress_', '');
      final json = _prefs.getString(key);
      if (json != null) {
        progress[cardId] = CardProgress.fromJson(jsonDecode(json) as Map<String, dynamic>);
      }
    }
    
    return progress;
  }
  
  @override
  Future<void> saveAllProgress(Map<String, CardProgress> progress) async {
    for (final entry in progress.entries) {
      await saveCardProgress(entry.value);
    }
  }
  
  @override
  Future<List<String>> getDueCards(DateTime date) async {
    final allProgress = await getAllProgress();
    final service = SpacedRepetitionService();
    return service.getDueCards(allProgress, date);
  }
  
  @override
  Future<StudySchedule> getScheduleForDate(DateTime date) async {
    final key = 'schedule_${_dateKey(date)}';
    final json = _prefs.getString(key);
    
    if (json != null) {
      return StudySchedule.fromJson(jsonDecode(json) as Map<String, dynamic>);
    }
    
    // Create empty schedule
    return StudySchedule(
      date: date,
      newCards: [],
      reviewCards: [],
      learningCards: [],
    );
  }
  
  @override
  Future<void> saveSchedule(StudySchedule schedule) async {
    final key = 'schedule_${_dateKey(schedule.date)}';
    await _prefs.setString(key, jsonEncode(schedule.toJson()));
  }
  
  @override
  Future<DailyStats?> getDailyStats(DateTime date) async {
    final key = 'stats_${_dateKey(date)}';
    final json = _prefs.getString(key);
    if (json == null) return null;
    return DailyStats.fromJson(jsonDecode(json) as Map<String, dynamic>);
  }
  
  @override
  Future<void> saveDailyStats(DailyStats stats) async {
    final key = 'stats_${_dateKey(stats.date)}';
    await _prefs.setString(key, jsonEncode(stats.toJson()));
  }
  
  @override
  Future<List<DailyStats>> getLast30DaysStats() async {
    final List<DailyStats> stats = [];
    final now = DateTime.now();
    
    for (int i = 0; i < 30; i++) {
      final date = now.subtract(Duration(days: i));
      final dayStats = await getDailyStats(date);
      if (dayStats != null) {
        stats.add(dayStats);
      }
    }
    
    return stats;
  }
  
  @override
  Future<void> resetAllProgress() async {
    final keys = _prefs.getKeys().where((k) => 
      k.startsWith('progress_') || 
      k.startsWith('stats_') || 
      k.startsWith('schedule_'));
    
    for (final key in keys) {
      await _prefs.remove(key);
    }
  }
  
  String _dateKey(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}
