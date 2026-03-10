import 'package:flutter/material.dart';
import 'package:deu_karten/core/theme/app_colors.dart';
import 'package:deu_karten/core/theme/app_typography.dart';

class StreakIndicator extends StatelessWidget {
  final int streak;
  final bool showLabel;
  final bool compact;

  const StreakIndicator({
    super.key,
    required this.streak,
    this.showLabel = true,
    this.compact = false,
  });

  @override
  Widget build(BuildContext context) {
    if (compact) {
      return Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        decoration: BoxDecoration(
          color: AppColors.streak.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(
              Icons.local_fire_department,
              color: AppColors.streak,
              size: 16,
            ),
            const SizedBox(width: 4),
            Text(
              streak.toString(),
              style: AppTypography.cardTitle.copyWith(
                color: AppColors.streak,
                fontSize: 14,
              ),
            ),
          ],
        ),
      );
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.streak.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(
            Icons.local_fire_department,
            color: AppColors.streak,
            size: 20,
          ),
          const SizedBox(width: 6),
          Text(
            streak.toString(),
            style: AppTypography.cardTitle.copyWith(
              color: AppColors.streak,
              fontSize: 16,
            ),
          ),
          if (showLabel) ...[
            const SizedBox(width: 4),
            Text(
              'Tage',
              style: AppTypography.caption.copyWith(
                color: AppColors.streak,
              ),
            ),
          ],
        ],
      ),
    );
  }
}
