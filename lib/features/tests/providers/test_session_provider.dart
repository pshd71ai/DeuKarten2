import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../models/test_session.dart' as models;
import '../models/test_model.dart';
import 'test_providers.dart';

part 'test_session_provider.g.dart';

@riverpod
class TestSessionNotifier extends _$TestSessionNotifier {
  @override
  models.TestSession? build() {
    return null;
  }

  void startTest(String testId) {
    final tests = ref.read(testsProvider);
    final test = tests.firstWhere((t) => t.id == testId);

    state = models.TestSession(
      test: test,
      userAnswers: List.filled(test.questions.length, -1),
      currentQuestionIndex: 0,
      startTime: DateTime.now(),
      timeLeft: test.duration != null ? test.duration! * 60 : null,
    );
  }

  void submitAnswer(int selectedIndex) {
    if (state == null) return;
    final currentSession = state!;
    final updatedAnswers = List<int>.from(currentSession.userAnswers);
    updatedAnswers[currentSession.currentQuestionIndex] = selectedIndex;
    state = currentSession.copyWith(userAnswers: updatedAnswers);
  }

  void nextQuestion() {
    if (state == null) return;
    if (state!.currentQuestionIndex < state!.totalQuestions - 1) {
      state = state!.copyWith(currentQuestionIndex: state!.currentQuestionIndex + 1);
    } else {
      _completeTest();
    }
  }

  void previousQuestion() {
    if (state == null) return;
    if (state!.currentQuestionIndex > 0) {
      state = state!.copyWith(currentQuestionIndex: state!.currentQuestionIndex - 1);
    }
  }

  void _completeTest() {
    if (state == null) return;
    final now = DateTime.now();
    final elapsed = now.difference(state!.startTime!).inSeconds;
    state = state!.copyWith(isComplete: true, timeElapsed: elapsed, timeLeft: 0);
  }

  void restart() {
    if (state == null) return;
    state = models.TestSession(
      test: state!.test,
      userAnswers: List.filled(state!.test.questions.length, -1),
      currentQuestionIndex: 0,
      startTime: DateTime.now(),
      timeLeft: state!.test.duration != null ? state!.test.duration! * 60 : null,
    );
  }

  void updateTimer() {
    if (state == null || state!.timeLeft == null || state!.timeLeft! <= 0) return;
    state = state!.copyWith(timeLeft: state!.timeLeft! - 1);
    if (state!.timeLeft == 0) {
      _completeTest();
    }
  }

  void reset() {
    state = null;
  }
}
