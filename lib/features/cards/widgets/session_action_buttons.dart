import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';

class SessionActionButtons extends StatelessWidget {
  final VoidCallback onDontKnow;
  final VoidCallback onKnow;

  const SessionActionButtons({
    super.key,
    required this.onDontKnow,
    required this.onKnow,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          // Don't know button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onDontKnow,
              icon: const Icon(Icons.close),
              label: const Text('Wusste nicht'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.error,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Know button
          Expanded(
            child: ElevatedButton.icon(
              onPressed: onKnow,
              icon: const Icon(Icons.check),
              label: const Text('Wusste'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.success,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                elevation: 2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
