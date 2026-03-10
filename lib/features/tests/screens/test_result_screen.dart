import 'package:flutter/material.dart';
import 'package:deu_karten/core/core.dart';

class TestResultScreen extends StatelessWidget {
  final int correctAnswers;
  final int totalQuestions;
  final int minPassingScore;
  final VoidCallback onRetry;
  final VoidCallback onBack;

  const TestResultScreen({
    super.key,
    required this.correctAnswers,
    required this.totalQuestions,
    required this.minPassingScore,
    required this.onRetry,
    required this.onBack,
  });

  double get percentage => totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0;
  bool get passed => percentage >= minPassingScore;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Results'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 120,
                    height: 120,
                    decoration: BoxDecoration(
                      color: passed ? AppColors.success : AppColors.error,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      passed ? Icons.check_circle : Icons.cancel,
                      size: 64,
                      color: AppColors.surface,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    passed ? 'Congratulations!' : 'Keep Practicing',
                    style: AppTypography.displayMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    passed
                        ? 'You passed the test!'
                        : 'You didn\'t reach the passing score',
                    style: AppTypography.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '${percentage.toStringAsFixed(0)}%',
                    style: AppTypography.displayLarge.copyWith(
                      color: passed ? AppColors.success : AppColors.error,
                      fontSize: 64,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '$correctAnswers out of $totalQuestions correct',
                    style: AppTypography.bodyLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Passing score: $minPassingScore%',
                    style: AppTypography.bodySmall.copyWith(
                      color: AppColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    text: 'Back',
                    isSecondary: true,
                    onPressed: onBack,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: AppButton(
                    text: 'Retry',
                    onPressed: onRetry,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
