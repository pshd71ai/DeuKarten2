import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:deu_karten/core/core.dart';
import '../models/card_model.dart';

class LearningScreen extends ConsumerStatefulWidget {
  final List<CardModel> cards;

  const LearningScreen({
    super.key,
    required this.cards,
  });

  @override
  ConsumerState<LearningScreen> createState() => _LearningScreenState();
}

class _LearningScreenState extends ConsumerState<LearningScreen>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  bool showTranslation = false;
  int correctAnswers = 0;
  int totalAnswered = 0;

  @override
  Widget build(BuildContext context) {
    if (widget.cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Learning'),
        ),
        body: const Center(
          child: Text('No cards to learn'),
        ),
      );
    }

    final card = widget.cards[currentIndex];
    final isLastCard = currentIndex == widget.cards.length - 1;

    return Scaffold(
      appBar: AppBar(
        title: Text('Learning ${currentIndex + 1}/${widget.cards.length}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    showTranslation = !showTranslation;
                  });
                },
                child: AppCard(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          card.german,
                          style: AppTypography.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                        if (showTranslation) ...[
                          const SizedBox(height: 24),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: AppColors.secondary.withOpacity(0.2),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              card.english,
                              style: AppTypography.displayMedium,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ),
            if (showTranslation) ...[
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _answer(false),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.error,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Wrong'),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: AppButton(
                      text: 'Correct',
                      onPressed: () => _answer(true),
                    ),
                  ),
                ],
              ),
            ] else
              const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }

  void _answer(bool correct) {
    setState(() {
      totalAnswered++;
      if (correct) correctAnswers++;
      showTranslation = false;

      if (currentIndex < widget.cards.length - 1) {
        currentIndex++;
      } else {
        _showResults();
      }
    });
  }

  void _showResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Learning Complete!'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Score: $correctAnswers/$totalAnswered',
              style: AppTypography.displayMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Accuracy: ${totalAnswered > 0 ? ((correctAnswers / totalAnswered) * 100).toStringAsFixed(0) : 0}%',
              style: AppTypography.bodyLarge,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).popUntil((route) => route.isFirst),
            child: const Text('Finish'),
          ),
        ],
      ),
    );
  }
}
