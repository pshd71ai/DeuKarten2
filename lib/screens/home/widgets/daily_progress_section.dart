import 'package:flutter/material.dart';
import 'package:deu_karten/core/theme/app_colors.dart';
import 'package:deu_karten/core/theme/app_typography.dart';
import 'package:deu_karten/core/widgets/progress_bar.dart';
import 'package:deu_karten/core/widgets/streak_indicator.dart';
import 'package:deu_karten/core/widgets/xp_indicator.dart';

class DailyProgressSection extends StatelessWidget {
  final int cardsLearnedToday;
  final int dailyGoal;
  final int streak;
  final int xpToday;

  const DailyProgressSection({
    super.key,
    required this.cardsLearnedToday,
    required this.dailyGoal,
    required this.streak,
    required this.xpToday,
  });

  double get _progress => cardsLearnedToday / dailyGoal;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.textTertiary.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Heute gelernt: $cardsLearnedToday/$dailyGoal Karten',
                style: AppTypography.bodyLarge,
              ),
              Text(
                '${(_progress * 100).toInt()}%',
                style: AppTypography.bodyLarge.copyWith(
                  color: AppColors.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          AppProgressBar(
            progress: _progress,
            progressColor: AppColors.primary,
            backgroundColor: AppColors.primary.withOpacity(0.1),
            height: 8,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              StreakIndicator(streak: streak, showLabel: true),
              XpIndicator(xp: xpToday),
            ],
          ),
        ],
      ),
    );
  }
}
