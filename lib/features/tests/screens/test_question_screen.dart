import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/progress_bar.dart';
import '../providers/test_session_provider.dart';
import '../widgets/question_widget.dart';

class TestQuestionScreen extends ConsumerStatefulWidget {
  final String testId;

  const TestQuestionScreen({required this.testId, super.key});

  @override
  ConsumerState<TestQuestionScreen> createState() => _TestQuestionScreenState();
}

class _TestQuestionScreenState extends ConsumerState<TestQuestionScreen> {
  int selectedOptionIndex = -1;

  @override
  Widget build(BuildContext context) {
    final session = ref.watch(testSessionNotifierProvider);

    if (session == null || session.currentQuestion == null) {
      return Scaffold(
        backgroundColor: AppColors.background,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final currentQuestion = session.currentQuestion!;
    final currentIndex = session.currentQuestionIndex;
    final totalQuestions = session.totalQuestions;

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.close, color: AppColors.textPrimary),
          onPressed: () => _showExitDialog(context),
        ),
        title: Text(
          'Frage ${currentIndex + 1} von $totalQuestions',
          style: TextStyle(color: AppColors.textPrimary),
        ),
        actions: [
          if (session.timeLeft != null)
            Padding(
              padding: const EdgeInsets.only(right: 16),
              child: Row(
                children: [
                  Icon(Icons.access_time, size: 20, color: AppColors.textSecondary),
                  const SizedBox(width: 4),
                  Text(
                    _formatTime(session.timeLeft!),
                    style: TextStyle(color: AppColors.textSecondary),
                  ),
                ],
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Progress Bar
            Padding(
              padding: const EdgeInsets.all(20),
              child: ProgressBar(
                progress: (currentIndex + 1) / totalQuestions,
                color: AppColors.primary,
              ),
            ),

            // Question
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: QuestionWidget(
                  question: currentQuestion,
                  selectedIndex: selectedOptionIndex,
                  onOptionSelected: (index) {
                    setState(() {
                      selectedOptionIndex = index;
                    });
                  },
                  showFeedback: false,
                ),
              ),
            ),

            // Navigation Buttons
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                children: [
                  Expanded(
                    child: AppButton(
                      text: currentIndex > 0 ? 'Zurück' : '',
                      onPressed: currentIndex > 0
                          ? () {
                              setState(() {
                                selectedOptionIndex = -1;
                              });
                              ref.read(testSessionNotifierProvider.notifier).previousQuestion();
                            }
                          : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 2,
                    child: AppButton(
                      text: currentIndex == totalQuestions - 1 ? 'Beenden' : 'Weiter',
                      onPressed: selectedOptionIndex >= 0
                          ? () => _handleNext(context, ref)
                          : null,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleNext(BuildContext context, WidgetRef ref) {
    ref.read(testSessionNotifierProvider.notifier).submitAnswer(selectedOptionIndex);

    if (ref.read(testSessionNotifierProvider)?.isComplete == true) {
      context.go('/tests/result');
    } else {
      setState(() {
        selectedOptionIndex = -1;
      });
    }
  }

  void _showExitDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Test verlassen?'),
        content: const Text('Ihr Fortschritt wird nicht gespeichert.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Abbrechen'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              ref.read(testSessionNotifierProvider.notifier).reset();
              context.go('/tests');
            },
            child: const Text('Verlassen', style: TextStyle(color: AppColors.error)),
          ),
        ],
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }
}
