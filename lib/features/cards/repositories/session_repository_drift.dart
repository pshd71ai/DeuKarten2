import 'package:uuid/uuid.dart';
import 'package:deu_karten/core/database/converters.dart';
import 'package:deu_karten/core/database/drift_database.dart';
import 'package:deu_karten/features/cards/models/learning_session.dart';
import 'package:deu_karten/features/cards/models/enums.dart';
import 'session_repository.dart';

class SessionRepositoryDrift implements SessionRepository {
  final AppDatabase _db;
  final Uuid _uuid = const Uuid();

  SessionRepositoryDrift(this._db);

  @override
  Future<LearningSession> createSession(String deckId) async {
    final session = LearningSession(
      id: _uuid.v4(),
      deckId: deckId,
      startedAt: DateTime.now(),
      completedAt: null,
      cards: [],
      cardsStudied: 0,
      correctAnswers: 0,
      xpEarned: 0,
      status: SessionStatus.inProgress,
    );

    await _db.into(_db.learningSessions).insert(
      learningSessionToData(session),
    );

    return session;
  }

  @override
  Future<LearningSession?> getCurrentSession() async {
    final data = await _db.getCurrentSession();
    return data != null ? learningSessionFromData(data) : null;
  }

  @override
  Future<void> saveSessionProgress(LearningSession session) async {
    await _db.update(_db.learningSessions).replace(
      learningSessionToData(session),
    );
  }

  @override
  Future<void> completeSession(String sessionId) async {
    final query = _db.select(_db.learningSessions)
      ..where((tbl) => tbl.id.equals(sessionId));

    final sessionData = await query.getSingleOrNull();

    if (sessionData != null) {
      final session = learningSessionFromData(sessionData);
      final updated = session.copyWith(
        status: SessionStatus.completed,
        completedAt: DateTime.now(),
      );

      await _db.update(_db.learningSessions).replace(
        learningSessionToData(updated),
      );
    }
  }

  @override
  Future<List<LearningSession>> getSessionHistory() async {
    final data = await _db.getSessionHistory();
    return data.map(learningSessionFromData).toList();
  }
}