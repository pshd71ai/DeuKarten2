import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SessionAppBar extends StatelessWidget implements PreferredSizeWidget {
  final double progress;
  final VoidCallback? onClose;

  const SessionAppBar({
    super.key,
    required this.progress,
    this.onClose,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leading: IconButton(
        onPressed: onClose ?? () => _showExitConfirmation(context),
        icon: const Icon(Icons.close),
        color: AppColors.textPrimary,
      ),
      title: ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: LinearProgressIndicator(
          value: progress,
          backgroundColor: AppColors.primary.withOpacity(0.1),
          valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
          minHeight: 6,
        ),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: () {
            // Show help or info
          },
          icon: const Icon(Icons.help_outline),
          color: AppColors.textSecondary,
        ),
      ],
    );
  }

  void _showExitConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Session beenden?',
          style: AppTypography.cardTitle,
        ),
        content: Text(
          'Möchtest du die Lernsession wirklich beenden? Dein Fortschritt wird nicht gespeichert.',
          style: AppTypography.body,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Weiterlernen'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.pop();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Beenden'),
          ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
