import 'package:flutter/material.dart';
import 'package:deu_karten/core/core.dart';
import '../models/card_model.dart';

class CardDetailScreen extends StatelessWidget {
  final CardModel card;

  const CardDetailScreen({
    super.key,
    required this.card,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Card Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    card.german,
                    style: AppTypography.displayMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    card.english,
                    style: AppTypography.headline.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            if (card.exampleGerman != null) ...[
              Text(
                'Example',
                style: AppTypography.headline,
              ),
              const SizedBox(height: 8),
              AppCard(
                child: Text(
                  card.exampleGerman!,
                  style: AppTypography.body,
                ),
              ),
            ],
            const SizedBox(height: 16),
            _buildStatRow('Category', card.category),
            const SizedBox(height: 12),
            _buildStatRow('Level', '${card.level}'),
            const SizedBox(height: 12),
            _buildStatRow('Review Count', '${card.reviewCount}'),
            const SizedBox(height: 12),
            _buildStatRow('Success Rate', '${(card.successRate * 100).toStringAsFixed(0)}%'),
          ],
        ),
      ),
    );
  }

  Widget _buildStatRow(String label, String value) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: AppTypography.body.copyWith(
            color: AppColors.textSecondary,
          ),
        ),
        Text(
          value,
          style: AppTypography.body.copyWith(
            fontWeight: AppTypography.body.fontWeight,
          ),
        ),
      ],
    );
  }
}
