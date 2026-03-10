import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deu_karten/core/core.dart';
import '../providers/statistics_providers.dart';
import '../widgets/stat_card_widget.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overallStats = ref.watch(overallStatisticsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Streak Card
            AppCard(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Current Streak',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Icon(
                            Icons.local_fire_department,
                            color: AppColors.secondary,
                            size: 28,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '${overallStats.currentStreak} days',
                            style: AppTypography.displayMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'Best Streak',
                        style: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${overallStats.longestStreak} days',
                        style: AppTypography.headline,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            // Statistics Grid
            GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              children: [
                StatCardWidget(
                  title: 'Cards Learned',
                  value: '${overallStats.totalCardsLearned}',
                  icon: Icons.style_outlined,
                  color: AppColors.primary,
                ),
                StatCardWidget(
                  title: 'Cards Reviewed',
                  value: '${overallStats.totalCardsReviewed}',
                  icon: Icons.refresh_outlined,
                  color: AppColors.info,
                ),
                StatCardWidget(
                  title: 'Tests Taken',
                  value: '${overallStats.totalTestsTaken}',
                  icon: Icons.quiz_outlined,
                  color: AppColors.secondary,
                ),
                StatCardWidget(
                  title: 'Study Time',
                  value: '${(overallStats.totalStudyTimeMinutes / 60).toStringAsFixed(1)}h',
                  icon: Icons.schedule,
                  color: AppColors.success,
                ),
              ],
            ),
            const SizedBox(height: 24),
            // Accuracy Section
            Text(
              'Performance',
              style: AppTypography.headline,
            ),
            const SizedBox(height: 16),
            AppCard(
              child: Column(
                children: [
                  _buildProgressRow(
                    'Overall Accuracy',
                    '${(overallStats.overallAccuracy * 100).toStringAsFixed(0)}%',
                    AppColors.primary,
                  ),
                  const Divider(),
                  _buildProgressRow(
                    'Average Test Score',
                    '${overallStats.averageTestScore.toStringAsFixed(0)}%',
                    AppColors.secondary,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressRow(String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: AppTypography.bodyMedium,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              value,
              style: AppTypography.bodyMedium.copyWith(
                color: color,
                fontWeight: AppTypography.fontWeightSemiBold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
