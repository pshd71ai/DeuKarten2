import '../models/learning_session.dart';
import '../models/enums.dart';

abstract class SessionRepository {
  Future<LearningSession> createSession(String deckId);
  Future<LearningSession?> getCurrentSession();
  Future<void> saveSessionProgress(LearningSession session);
  Future<void> completeSession(String sessionId);
  Future<List<LearningSession>> getSessionHistory();
}

class SessionRepositoryImpl implements SessionRepository {
  LearningSession? _currentSession;
  final List<LearningSession> _sessionHistory = [];

  @override
  Future<LearningSession> createSession(String deckId) async {
    _currentSession = LearningSession(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      deckId: deckId,
      startedAt: DateTime.now(),
      cards: [],
      status: SessionStatus.inProgress,
    );
    return _currentSession!;
  }

  @override
  Future<LearningSession?> getCurrentSession() async {
    return _currentSession;
  }

  @override
  Future<void> saveSessionProgress(LearningSession session) async {
    _currentSession = session;
  }

  @override
  Future<void> completeSession(String sessionId) async {
    if (_currentSession?.id == sessionId) {
      _currentSession = _currentSession!.copyWith(
        status: SessionStatus.completed,
        completedAt: DateTime.now(),
      );
      _sessionHistory.add(_currentSession!);
      _currentSession = null;
    }
  }

  @override
  Future<List<LearningSession>> getSessionHistory() async {
    return _sessionHistory;
  }
}
