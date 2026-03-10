import 'package:flutter/material.dart';
import 'package:deu_karten/core/core.dart';

class TeacherAvatarWidget extends StatelessWidget {
  final double size;
  final bool isAnimating;

  const TeacherAvatarWidget({
    super.key,
    this.size = 80,
    this.isAnimating = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primary,
            AppColors.primaryDark,
          ],
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Icon(
        Icons.psychology_outlined,
        size: size * 0.5,
        color: AppColors.surface,
      ),
    );
  }
}
