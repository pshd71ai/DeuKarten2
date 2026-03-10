import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../models/enums.dart';
import '../providers/session_provider.dart';

class CardFront extends StatelessWidget {
  final CardData card;

  const CardFront({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Container(
        width: 320,
        height: 420,
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Card type badge
            CardTypeBadge(type: card.type),
            const Spacer(),

            // Content based on card type
            _buildCardContent(),

            const Spacer(),

            // Hint text
            Text(
              'Tippen zum Umkehren',
              style: AppTypography.caption.copyWith(
                color: AppColors.textTertiary,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCardContent() {
    switch (card.type) {
      case CardType.noun:
      case CardType.verb:
      case CardType.adjective:
        return WordCardFrontContent(card: card);
      case CardType.article:
        return ArticleCardFrontContent(card: card);
      case CardType.sentence:
        return SentenceCardFrontContent(card: card);
      default:
        return WordCardFrontContent(card: card);
    }
  }
}

class CardTypeBadge extends StatelessWidget {
  final CardType type;

  const CardTypeBadge({
    super.key,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    String label;
    Color color;

    switch (type) {
      case CardType.noun:
        label = 'Nomen';
        color = AppColors.primary;
      case CardType.verb:
        label = 'Verb';
        color = AppColors.success;
      case CardType.adjective:
        label = 'Adjektiv';
        color = AppColors.warning;
      case CardType.article:
        label = 'Artikel';
        color = AppColors.secondary;
      case CardType.sentence:
        label = 'Satz';
        color = AppColors.accent;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Text(
        label,
        style: AppTypography.caption.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

class WordCardFrontContent extends StatelessWidget {
  final CardData card;

  const WordCardFrontContent({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Emoji or placeholder
        Text(
          card.imageUrl ?? '📚',
          style: const TextStyle(fontSize: 80),
        ),
        const SizedBox(height: 24),

        // German word with article
        if (card.germanWord != null)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (card.article != null && card.article!.isNotEmpty) ...[
                Text(
                  card.article!,
                  style: AppTypography.section.copyWith(
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              Text(
                card.germanWord!,
                style: AppTypography.germanWord,
              ),
            ],
          ),

        // Plural form if noun
        if (card.pluralForm != null && card.pluralForm!.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Text(
              'Pl: ${card.pluralForm}',
              style: AppTypography.caption,
            ),
          ),
      ],
    );
  }
}

class ArticleCardFrontContent extends StatelessWidget {
  final CardData card;

  const ArticleCardFrontContent({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (card.germanWord != null)
          Text(
            '___ ${card.germanWord}',
            style: AppTypography.germanWord,
          ),
        const SizedBox(height: 32),
        Text(
          'Wähle den richtigen Artikel',
          style: AppTypography.body.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        if (card.articleOptions != null)
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: card.articleOptions!.map((option) {
              return ChoiceChip(
                label: Text(option),
                selected: false,
                onSelected: (_) {},
              );
            }).toList(),
          ),
      ],
    );
  }
}

class SentenceCardFrontContent extends StatelessWidget {
  final CardData card;

  const SentenceCardFrontContent({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (card.incompleteSentence != null)
          Text(
            card.incompleteSentence!,
            style: AppTypography.section,
            textAlign: TextAlign.center,
          ),
        const SizedBox(height: 32),
        if (card.wordOptions != null)
          Wrap(
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.center,
            children: card.wordOptions!.map((word) {
              return ActionChip(
                label: Text(word),
                onPressed: () {},
              );
            }).toList(),
          ),
        if (card.grammarTopic != null) ...[
          const SizedBox(height: 24),
          Text(
            card.grammarTopic!,
            style: AppTypography.caption.copyWith(
              color: AppColors.textTertiary,
              fontStyle: FontStyle.italic,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ],
    );
  }
}
