import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lottie/lottie.dart';
import 'package:deu_karten/core/theme/app_colors.dart';

class LevelUpWidget extends StatelessWidget {
  final int newLevel;
  final VoidCallback? onComplete;

  const LevelUpWidget({
    super.key,
    required this.newLevel,
    this.onComplete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(32),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primary.withOpacity(0.8),
            AppColors.secondary,
          ],
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.4),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Level up animation
          Lottie.asset(
            'assets/animations/level_up.json',
            width: 200,
            height: 200,
            repeat: false,
          ),
          const SizedBox(height: 16),
          const Text(
            'LEVEL UP!',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
              letterSpacing: 4,
            ),
          )
              .animate()
              .scale(
                begin: const Offset(0.5, 0.5),
                end: const Offset(1, 1),
                duration: 500.ms,
                curve: Curves.elasticOut,
              ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.military_tech,
                  color: Colors.yellow,
                  size: 32,
                ),
                const SizedBox(width: 12),
                Text(
                  'Level $newLevel',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          )
              .animate(delay: 300.ms)
              .scale(
                begin: const Offset(0, 0),
                end: const Offset(1, 1),
                duration: 600.ms,
                curve: Curves.elasticOut,
              ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onComplete,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: const Text(
              'Weiter',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
              .animate(delay: 600.ms)
              .fadeIn()
              .slideY(begin: 0.5, end: 0),
        ],
      ),
    )
        .animate()
        .scale(
          begin: const Offset(0.3, 0.3),
          end: const Offset(1, 1),
          duration: 600.ms,
          curve: Curves.elasticOut,
        )
        .fadeIn(duration: 300.ms);
  }
}
