import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:deu_karten/core/theme/app_colors.dart';
import 'package:deu_karten/core/theme/app_typography.dart';

class SessionProgressAnimation extends StatelessWidget {
  final int correctAnswers;
  final int totalCards;
  final int xpEarned;
  final VoidCallback? onComplete;

  const SessionProgressAnimation({
    super.key,
    required this.correctAnswers,
    required this.totalCards,
    required this.xpEarned,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    final accuracy = correctAnswers / totalCards;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 20,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Success checkmark
          Lottie.asset(
            'assets/animations/success_check.json',
            width: 150,
            height: 150,
            repeat: false,
          ),
          const SizedBox(height: 16),

          // Stats with animations
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildStatCard(
                icon: Icons.check_circle,
                value: '$correctAnswers',
                label: 'Richtig',
                color: AppColors.success,
                delay: 0,
              ),
              _buildStatCard(
                icon: Icons.style,
                value: '$totalCards',
                label: 'Gesamt',
                color: AppColors.primary,
                delay: 200,
              ),
              _buildStatCard(
                icon: Icons.star,
                value: '$xpEarned',
                label: 'XP',
                color: AppColors.xp,
                delay: 400,
              ),
            ],
          ),

          const SizedBox(height: 24),

          // Accuracy bar
          _buildAccuracyBar(accuracy),

          const SizedBox(height: 24),

          // Continue button
          ElevatedButton(
            onPressed: onComplete,
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.symmetric(
                horizontal: 48,
                vertical: 16,
              ),
            ),
            child: const Text('Weiter'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required int delay,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Icon(icon, color: color, size: 32),
          const SizedBox(height: 8),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          Text(
            label,
            style: AppTypography.caption,
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: delay))
        .scale(begin: const Offset(0, 0), end: const Offset(1, 1))
        .fadeIn();
  }

  Widget _buildAccuracyBar(double accuracy) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Genauigkeit', style: AppTypography.body),
            Text(
              '${(accuracy * 100).toInt()}%',
              style: AppTypography.body.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: accuracy,
            minHeight: 16,
            backgroundColor: AppColors.error.withOpacity(0.2),
            valueColor: AlwaysStoppedAnimation<Color>(
              accuracy >= 0.8
                  ? AppColors.success
                  : accuracy >= 0.6
                      ? AppColors.warning
                      : AppColors.error,
            ),
          ),
        )
            .animate()
            .slideX(
              begin: -1,
              end: 0,
              duration: 800.ms,
              curve: Curves.easeOutCubic,
            ),
      ],
    );
  }
}
