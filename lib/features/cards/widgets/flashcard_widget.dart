import 'package:flutter/material.dart';
import 'package:deu_karten/core/core.dart';
import '../models/card_model.dart';

class FlashcardWidget extends StatefulWidget {
  final CardModel card;
  final VoidCallback? onTap;
  final bool showTranslation;

  const FlashcardWidget({
    super.key,
    required this.card,
    this.onTap,
    this.showTranslation = false,
  });

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void didUpdateWidget(FlashcardWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.showTranslation != oldWidget.showTranslation) {
      if (widget.showTranslation) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: AppCard(
        padding: EdgeInsets.zero,
        child: Container(
          height: 300,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: widget.showTranslation
                  ? [AppColors.secondaryLight, AppColors.secondary]
                  : [AppColors.primaryLight, AppColors.primary],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  widget.showTranslation ? Icons.translate : Icons.language,
                  size: 48,
                  color: widget.showTranslation
                      ? AppColors.textPrimary
                      : AppColors.surface,
                ),
                const SizedBox(height: 24),
                Text(
                  widget.showTranslation ? widget.card.english : widget.card.german,
                  style: AppTypography.germanWord.copyWith(
                    color: widget.showTranslation
                        ? AppColors.textPrimary
                        : AppColors.surface,
                  ),
                  textAlign: TextAlign.center,
                ),
                if (widget.card.exampleGerman != null && widget.showTranslation) ...[
                  const SizedBox(height: 16),
                  Text(
                    widget.card.exampleGerman!,
                    style: AppTypography.body.copyWith(
                      color: widget.showTranslation
                          ? AppColors.textSecondary
                          : AppColors.surface.withOpacity(0.8),
                      fontStyle: FontStyle.italic,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
