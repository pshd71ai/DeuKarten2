import 'package:flutter/material.dart';
import 'package:deu_karten/core/theme/app_colors.dart';

// Alias for AppProgressBar to match expected usage
typedef ProgressBar = AppProgressBar;

class AppProgressBar extends StatelessWidget {
  final double progress; // 0.0 to 1.0
  final Color? backgroundColor;
  final Color? progressColor;
  final double height;
  final Color? color; // Alias for progressColor

  const AppProgressBar({
    super.key,
    required this.progress,
    this.backgroundColor,
    this.progressColor,
    this.color,
    this.height = 8.0,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppColors.textTertiary.withOpacity(0.2);
    final prog = color ?? progressColor ?? AppColors.primary;

    return ClipRRect(
      borderRadius: BorderRadius.circular(height / 2),
      child: SizedBox(
        height: height,
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              color: bg,
            ),
            FractionallySizedBox(
              widthFactor: progress.clamp(0.0, 1.0),
              child: Container(
                color: prog,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
