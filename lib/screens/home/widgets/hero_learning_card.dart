import 'package:flutter/material.dart';
import 'package:deu_karten/core/theme/app_colors.dart';
import 'package:deu_karten/core/theme/app_typography.dart';

class HeroLearningCard extends StatelessWidget {
  final bool hasOngoingSession;
  final int cardsReady;
  final String? currentDeckName;
  final int? remainingCards;
  final VoidCallback onStart;

  const HeroLearningCard({
    super.key,
    required this.hasOngoingSession,
    required this.cardsReady,
    this.currentDeckName,
    this.remainingCards,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryDark],
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            hasOngoingSession ? 'Weiter lernen' : 'Heute lernen',
            style: AppTypography.title.copyWith(
              color: Colors.white,
              fontSize: 28,
            ),
          ),
          const SizedBox(height: 8),
          if (hasOngoingSession && currentDeckName != null) ...[
            Text(
              currentDeckName!,
              style: AppTypography.bodyLarge.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '$remainingCards Karten übrig',
              style: AppTypography.body.copyWith(
                color: Colors.white.withOpacity(0.8),
                fontSize: 16,
              ),
            ),
          ] else ...[
            Text(
              '$cardsReady Karten bereit',
              style: AppTypography.bodyLarge.copyWith(
                color: Colors.white.withOpacity(0.9),
                fontSize: 18,
              ),
            ),
          ],
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: onStart,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.white,
              foregroundColor: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              hasOngoingSession ? 'Weiter lernen' : 'Start Lernen',
              style: AppTypography.button.copyWith(
                color: AppColors.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
