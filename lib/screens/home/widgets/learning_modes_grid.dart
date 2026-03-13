import 'package:flutter/material.dart';
import 'package:deu_karten/core/theme/app_colors.dart';
import 'learning_mode_card.dart';

class LearningModesGrid extends StatelessWidget {
  final VoidCallback onKartenTap;
  final VoidCallback onSaetzeTap;
  final VoidCallback onHoerenTap;

  const LearningModesGrid({
    super.key,
    required this.onKartenTap,
    required this.onSaetzeTap,
    required this.onHoerenTap,
  });

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 0.6,
      children: [
        HomeLearningModeCard(
          title: 'Karten lernen',
          subtitle: 'Flashcards',
          icon: Icons.style,
          color: AppColors.primary,
          onTap: onKartenTap,
        ),
        HomeLearningModeCard(
          title: 'Sätze bauen',
          subtitle: 'Sentence builder',
          icon: Icons.format_quote,
          color: AppColors.secondary,
          onTap: onSaetzeTap,
        ),
        HomeLearningModeCard(
          title: 'Hören',
          subtitle: 'Listening training',
          icon: Icons.headphones,
          color: AppColors.accent,
          onTap: onHoerenTap,
        ),
      ],
    );
  }
}
