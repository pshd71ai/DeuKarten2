import 'package:flutter/material.dart';
import 'package:deu_karten/core/core.dart';
import '../models/test_model.dart';

class TestDetailScreen extends StatelessWidget {
  final TestModel test;

  const TestDetailScreen({
    super.key,
    required this.test,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              test.title,
              style: AppTypography.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              test.description,
              style: AppTypography.body.copyWith(
                color: AppColors.textSecondary,
              ),
            ),
            const SizedBox(height: 24),
            AppCard(
              child: Column(
                children: [
                  _buildInfoRow(
                    Icons.schedule,
                    'Duration',
                    '${test.duration} minutes',
                  ),
                  const Divider(),
                  _buildInfoRow(
                    Icons.help_outline,
                    'Questions',
                    '${test.totalQuestions}',
                  ),
                  const Divider(),
                  _buildInfoRow(
                    Icons.category,
                    'Category',
                    test.category,
                  ),
                  const Divider(),
                  _buildInfoRow(
                    Icons.emoji_events,
                    'Passing Score',
                    '${test.minPassingScore}%',
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            AppButton(
              text: 'Start Test',
              onPressed: () {
                // TODO: Navigate to test taking screen
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, color: AppColors.primary, size: 20),
          const SizedBox(width: 12),
          Text(
            label,
            style: AppTypography.body.copyWith(
              color: AppColors.textSecondary,
            ),
          ),
          const Spacer(),
          Text(
            value,
            style: AppTypography.body.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
