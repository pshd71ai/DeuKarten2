import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/session_provider.dart';

class CardBack extends StatelessWidget {
  final CardData card;

  const CardBack({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      color: AppColors.primary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 320,
        height: 420,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Full sentence display if applicable
            if (card.completeSentence != null) ...[
              Text(
                'Vollständiger Satz',
                style: AppTypography.caption.copyWith(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                card.completeSentence!,
                style: AppTypography.section.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],

            // German word with correct article (for article cards)
            if (card.type.name == 'article' && card.germanWord != null) ...[
              Text(
                'Richtige Antwort',
                style: AppTypography.caption.copyWith(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                '${card.article} ${card.germanWord}',
                style: AppTypography.germanWord.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
            ],

            // Translation
            Text(
              'Übersetzung',
              style: AppTypography.caption.copyWith(
                color: Colors.white.withOpacity(0.7),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              card.translation,
              style: AppTypography.cardTitle.copyWith(
                color: Colors.white,
              ),
              textAlign: TextAlign.center,
            ),

            const SizedBox(height: 32),

            // Example sentence
            if (card.exampleSentence != null) ...[
              Text(
                'Beispiel',
                style: AppTypography.caption.copyWith(
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                card.exampleSentence!,
                style: AppTypography.body.copyWith(
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),
              if (card.exampleTranslation != null) ...[
                const SizedBox(height: 4),
                Text(
                  card.exampleTranslation!,
                  style: AppTypography.caption.copyWith(
                    color: Colors.white.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ],

            const Spacer(),

            // Instructions
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(
                '← Wusste nicht    Wusste →',
                style: AppTypography.caption.copyWith(
                  color: Colors.white.withOpacity(0.9),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
