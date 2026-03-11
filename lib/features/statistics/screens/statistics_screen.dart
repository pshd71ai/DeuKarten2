import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../../../core/widgets/app_card.dart';
import '../providers/statistics_providers.dart';
import '../widgets/stat_card_widget.dart';
import '../widgets/streak_card_widget.dart';
import '../widgets/weekly_progress_widget.dart';
import '../widgets/retention_rate_widget.dart';
import '../widgets/xp_summary_widget.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final overallStats = ref.watch(overallStatisticsProvider);
    final todayStats = ref.watch(todayStatisticsProvider);
    final weekStats = ref.watch(weekStatisticsProvider);

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            _buildHeader(context),

            // Content
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Streak Card
                    StreakCardWidget(
                      currentStreak: overallStats.currentStreak,
                      longestStreak: overallStats.longestStreak,
                    ),
                    const SizedBox(height: 20),

                    // Today's Summary
                    _buildTodaySummary(todayStats),
                    const SizedBox(height: 20),

                    // Weekly Progress
                    WeeklyProgressWidget(
                      weekData: weekStats,
                    ),
                    const SizedBox(height: 20),

                    // XP Summary
                    XPSummaryWidget(
                      totalXP: overallStats.totalXP,
                      todayXP: todayStats.xpEarned,
                    ),
                    const SizedBox(height: 20),

                    // Retention Rate
                    RetentionRateWidget(
                      retentionRate: overallStats.retentionRate,
                    ),
                    const SizedBox(height: 20),

                    // Stats Grid
                    _buildStatsGrid(overallStats),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Statistik',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                Text(
                  'Woche',
                  style: TextStyle(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(width: 4),
                Icon(Icons.keyboard_arrow_down,
                     size: 20, color: AppColors.primary),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTodaySummary(DailyStatistics todayStats) {
    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Heute gelernt',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _TodayItem(
                  icon: Icons.style_outlined,
                  label: 'Karten',
                  value: todayStats.cardsLearned.toString(),
                  color: AppColors.primary,
                ),
              ),
              Expanded(
                child: _TodayItem(
                  icon: Icons.quiz_outlined,
                  label: 'Tests',
                  value: todayStats.testsCompleted.toString(),
                  color: AppColors.secondary,
                ),
              ),
              Expanded(
                child: _TodayItem(
                  icon: Icons.access_time,
                  label: 'Zeit',
                  value: '${todayStats.studyMinutes}m',
                  color: AppColors.success,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildStatsGrid(OverallStatistics stats) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: [
        StatCardWidget(
          title: 'Gesamt Karten',
          value: stats.totalCardsReviewed.toString(),
          icon: Icons.style_outlined,
          color: AppColors.primary,
        ),
        StatCardWidget(
          title: 'Tests absolviert',
          value: stats.totalTestsTaken.toString(),
          icon: Icons.quiz_outlined,
          color: AppColors.secondary,
        ),
        StatCardWidget(
          title: 'Genauigkeit',
          value: '${(stats.overallAccuracy * 100).toInt()}%',
          icon: Icons.check_circle_outline,
          color: AppColors.success,
        ),
        StatCardWidget(
          title: 'Lernzeit',
          value: '${(stats.totalStudyTimeMinutes / 60).toInt()}h',
          icon: Icons.schedule,
          color: AppColors.info,
        ),
      ],
    );
  }
}

class _TodayItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;
  final Color color;

  const _TodayItem({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
