import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:deu_karten/core/theme/app_colors.dart';
import '../models/streak_model.dart';

class StreakMilestoneWidget extends StatelessWidget {
  final StreakMilestone milestone;
  final VoidCallback? onComplete;

  const StreakMilestoneWidget({
    super.key,
    required this.milestone,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.streak,
            AppColors.streak.withOpacity(0.8),
            Colors.orange,
          ],
        ),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Confetti animation
          Lottie.asset(
            'assets/animations/confetti.json',
            width: 200,
            height: 200,
            repeat: false,
            onLoaded: (_) {
              Future.delayed(const Duration(seconds: 3), () {
                onComplete?.call();
              });
            },
          ),
          const SizedBox(height: 16),
          const Icon(
            Icons.emoji_events,
            size: 64,
            color: Colors.yellow,
          ),
          const SizedBox(height: 16),
          Text(
            milestone.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${milestone.days} Tage Streak!',
            style: TextStyle(
              color: Colors.white.withOpacity(0.9),
              fontSize: 20,
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.star,
                  color: Colors.yellow,
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  '+${milestone.bonusXp} XP Bonus',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    )
        .animate()
        .scale(
          begin: const Offset(0.5, 0.5),
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 300.ms);
  }
}
