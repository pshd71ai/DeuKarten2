import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../models/card_progress.dart';

class CardProgressIndicator extends StatelessWidget {
  final CardProgress progress;
  
  const CardProgressIndicator({
    super.key,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: _getStatusColor(progress.status).withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: _getStatusColor(progress.status).withOpacity(0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getStatusIcon(progress.status),
                color: _getStatusColor(progress.status),
                size: 16,
              ),
              const SizedBox(width: 6),
              Text(
                progress.status.label,
                style: TextStyle(
                  color: _getStatusColor(progress.status),
                  fontWeight: FontWeight.w600,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          if (progress.intervalDays > 0) ...[
            Text(
              'Nächste Wiederholung: ${_formatDate(progress.nextReview)}',
              style: AppTypography.caption,
            ),
            const SizedBox(height: 4),
            Text(
              'Intervall: ${progress.intervalDays} Tage',
              style: AppTypography.caption,
            ),
          ],
          // Ease factor indicator
          Row(
            children: [
              Text('Leichtigkeit: ', style: AppTypography.caption),
              _buildEaseFactorStars(progress.easeFactor),
            ],
          ),
        ],
      ),
    );
  }
  
  Widget _buildEaseFactorStars(double easeFactor) {
    final stars = (easeFactor / 2.5 * 5).round().clamp(1, 5);
    return Row(
      children: List.generate(5, (index) {
        return Icon(
          index < stars ? Icons.star : Icons.star_border,
          size: 12,
          color: index < stars ? AppColors.xp : AppColors.textTertiary,
        );
      }),
    );
  }
  
  Color _getStatusColor(SRSStatus status) {
    return switch (status) {
      SRSStatus.newCard => Colors.blue,
      SRSStatus.learning => Colors.orange,
      SRSStatus.review => Colors.green,
      SRSStatus.mastered => Colors.purple,
      SRSStatus.suspended => Colors.grey,
    };
  }
  
  IconData _getStatusIcon(SRSStatus status) {
    return switch (status) {
      SRSStatus.newCard => Icons.fiber_new,
      SRSStatus.learning => Icons.school,
      SRSStatus.review => Icons.refresh,
      SRSStatus.mastered => Icons.emoji_events,
      SRSStatus.suspended => Icons.pause,
    };
  }
  
  String _formatDate(DateTime? date) {
    if (date == null) return 'Heute';
    
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final reviewDay = DateTime(date.year, date.month, date.day);
    
    if (reviewDay == today) return 'Heute';
    if (reviewDay == tomorrow) return 'Morgen';
    return '${date.day}.${date.month}.';
  }
}
