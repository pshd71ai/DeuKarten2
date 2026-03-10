import 'package:flutter/material.dart';
import 'package:deu_karten/core/theme/app_colors.dart';
import 'package:deu_karten/core/theme/app_typography.dart';
import 'package:deu_karten/core/widgets/app_card.dart';
import 'package:deu_karten/core/widgets/progress_bar.dart';

class RecentDecksSection extends StatelessWidget {
  const RecentDecksSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildDeckCard(
            'A1 Verben',
            45,
            80,
            AppColors.primary,
          ),
          const SizedBox(width: 12),
          _buildDeckCard(
            'Essen & Trinken',
            32,
            60,
            AppColors.secondary,
          ),
          const SizedBox(width: 12),
          _buildDeckCard(
            'B1 Vokabeln',
            15,
            100,
            AppColors.accent,
          ),
        ],
      ),
    );
  }

  Widget _buildDeckCard(String name, int learned, int total, Color color) {
    final progress = learned / total;

    return SizedBox(
      width: 160,
      child: AppCard(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.folder,
                color: color,
                size: 24,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              name,
              style: AppTypography.cardTitle.copyWith(fontSize: 16),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Text(
              '$learned / $total Karten',
              style: AppTypography.caption,
            ),
            const Spacer(),
            AppProgressBar(
              progress: progress,
              progressColor: color,
              backgroundColor: color.withOpacity(0.1),
              height: 6,
            ),
          ],
        ),
      ),
    );
  }
}
