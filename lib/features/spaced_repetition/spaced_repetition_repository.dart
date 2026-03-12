import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../cards/models/card_progress.dart';
import 'sm2_algorithm.dart';

abstract class SpacedRepetitionRepository {
  Future<CardProgress> getProgress(String cardId);
  Future<Map<String, CardProgress>> getAllProgress();
  Future<void> saveProgress(CardProgress progress);
  Future<void> saveAllProgress(Map<String, CardProgress> progressMap);
  Future<List<String>> getDueCardIds(List<String> allCardIds);
  Future<int> getDueCount(List<String> allCardIds);
  Future<void> applyReview({
    required String cardId,
    required bool wasCorrect,
  });
  Future<void> clearAll();
}

class SpacedRepetitionRepositoryImpl implements SpacedRepetitionRepository {
  final SharedPreferences _prefs;

  static const String _storageKey = 'sr_card_progress';

  SpacedRepetitionRepositoryImpl(this._prefs);

  Future<Map<String, CardProgress>> _loadAll() async {
    final raw = _prefs.getString(_storageKey);
    if (raw == null) return {};
    final json = jsonDecode(raw) as Map<String, dynamic>;
    return json.map((key, value) =>
        MapEntry(key, CardProgress.fromJson(value as Map<String, dynamic>)));
  }

  Future<void> _persistAll(Map<String, CardProgress> map) async {
    final json = map.map((key, value) => MapEntry(key, value.toJson()));
    await _prefs.setString(_storageKey, jsonEncode(json));
  }

  @override
  Future<CardProgress> getProgress(String cardId) async {
    final all = await _loadAll();
    return all[cardId] ?? SM2Algorithm.newProgress(cardId);
  }

  @override
  Future<Map<String, CardProgress>> getAllProgress() async {
    return _loadAll();
  }

  @override
  Future<void> saveProgress(CardProgress progress) async {
    final all = await _loadAll();
    all[progress.cardId] = progress;
    await _persistAll(all);
  }

  @override
  Future<void> saveAllProgress(Map<String, CardProgress> progressMap) async {
    final all = await _loadAll();
    all.addAll(progressMap);
    await _persistAll(all);
  }

  @override
  Future<List<String>> getDueCardIds(List<String> allCardIds) async {
    final all = await _loadAll();
    return allCardIds.where((id) {
      final progress = all[id] ?? SM2Algorithm.newProgress(id);
      return SM2Algorithm.isDueToday(progress);
    }).toList();
  }

  @override
  Future<int> getDueCount(List<String> allCardIds) async {
    final due = await getDueCardIds(allCardIds);
    return due.length;
  }

  @override
  Future<void> applyReview({
    required String cardId,
    required bool wasCorrect,
  }) async {
    final progress = await getProgress(cardId);
    final quality = SM2Algorithm.boolToQuality(wasCorrect);
    final updated = SM2Algorithm.calculate(progress: progress, quality: quality);
    await saveProgress(updated);
  }

  @override
  Future<void> clearAll() async {
    await _prefs.remove(_storageKey);
  }
}
