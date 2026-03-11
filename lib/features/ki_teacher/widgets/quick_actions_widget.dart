import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';

class QuickActionsWidget extends StatelessWidget {
  final Function(String) onActionSelected;

  const QuickActionsWidget({
    required this.onActionSelected,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        border: Border(
          bottom: BorderSide(color: AppColors.primaryLight.withOpacity(0.5)),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Schnellaktionen',
            style: TextStyle(
              fontSize: 12,
              color: AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 12),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _QuickActionButton(
                  icon: Icons.menu_book_outlined,
                  label: 'Erkläre Grammatik',
                  prompt: 'Erkläre mir die deutsche Grammatik',
                  color: AppColors.primary,
                  onTap: onActionSelected,
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  icon: Icons.chat_outlined,
                  label: 'Übe Dialog',
                  prompt: 'Lass uns einen Dialog auf Deutsch üben',
                  color: AppColors.success,
                  onTap: onActionSelected,
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  icon: Icons.spellcheck_outlined,
                  label: 'Korrigiere Satz',
                  prompt: 'Korrigiere diesen Satz: ',
                  color: AppColors.warning,
                  onTap: onActionSelected,
                ),
                const SizedBox(width: 12),
                _QuickActionButton(
                  icon: Icons.translate,
                  label: 'Neue Wörter',
                  prompt: 'Erkläre mir neue deutsche Wörter',
                  color: AppColors.accent,
                  onTap: onActionSelected,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final String prompt;
  final Color color;
  final Function(String) onTap;

  const _QuickActionButton({
    required this.icon,
    required this.label,
    required this.prompt,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onTap(prompt),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 18, color: color),
            const SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
