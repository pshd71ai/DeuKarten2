import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../models/question_model.dart';

class QuestionWidget extends StatelessWidget {
  final QuestionModel question;
  final int selectedIndex;
  final Function(int) onOptionSelected;
  final bool showFeedback;

  const QuestionWidget({
    required this.question,
    required this.selectedIndex,
    required this.onOptionSelected,
    this.showFeedback = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Question
        Text(
          question.question,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 24),

        // Options
        ...question.options.asMap().entries.map((entry) {
          final index = entry.key;
          final option = entry.value;
          final isSelected = selectedIndex == index;
          final isCorrect = index == question.correctAnswerIndex;

          Color? bgColor;
          Color? textColor;
          Color? borderColor;

          if (showFeedback) {
            if (isCorrect) {
              bgColor = AppColors.success.withOpacity(0.1);
              textColor = AppColors.success;
              borderColor = AppColors.success;
            } else if (isSelected && !isCorrect) {
              bgColor = AppColors.error.withOpacity(0.1);
              textColor = AppColors.error;
              borderColor = AppColors.error;
            }
          } else if (isSelected) {
            bgColor = AppColors.primary.withOpacity(0.1);
            textColor = AppColors.primary;
            borderColor = AppColors.primary;
          }

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: InkWell(
              onTap: showFeedback ? null : () => onOptionSelected(index),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: bgColor ?? AppColors.surface,
                  border: Border.all(
                    color: borderColor ?? AppColors.primaryLight,
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isSelected
                            ? (showFeedback
                                ? (isCorrect ? AppColors.success : AppColors.error)
                                : AppColors.primary)
                            : AppColors.primaryLight,
                      ),
                      child: Center(
                        child: Text(
                          String.fromCharCode(65 + index), // A, B, C, D
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : AppColors.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        option,
                        style: TextStyle(
                          fontSize: 16,
                          color: textColor ?? AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }),
      ],
    );
  }
}
