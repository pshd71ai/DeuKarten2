import 'package:flutter/material.dart';
import 'package:deu_karten/core/theme/app_colors.dart';
import 'package:deu_karten/core/theme/app_typography.dart';

// Alias for XpIndicator to match expected usage
typedef XPIndicator = XpIndicator;

class XpIndicator extends StatelessWidget {
  final int xp;
  final bool showProgress;
  final int? nextLevelXp;

  const XpIndicator({
    super.key,
    required this.xp,
    this.showProgress = false,
    this.nextLevelXp,
  });

  // Constructor for amount parameter to match expected usage
  const XpIndicator.amount({
    super.key,
    required int amount,
    this.showProgress = false,
    this.nextLevelXp,
  }) : xp = amount;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.xp.withOpacity(0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.star,
                color: AppColors.xp,
                size: 18,
              ),
              const SizedBox(width: 6),
              Text(
                '$xp XP',
                style: AppTypography.cardTitle.copyWith(
                  color: AppColors.xp,
                  fontSize: 15,
                ),
              ),
            ],
          ),
        ),
        if (showProgress && nextLevelXp != null) ...[
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: xp / nextLevelXp!,
              backgroundColor: AppColors.xp.withOpacity(0.2),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.xp),
              minHeight: 4,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '$xp / $nextLevelXp XP',
            style: AppTypography.caption,
          ),
        ],
      ],
    );
  }
}
