import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';

class RetentionRateWidget extends StatelessWidget {
  final double retentionRate;

  const RetentionRateWidget({
    required this.retentionRate,
    super.key,
  });

  Color get _getRetentionColor {
    if (retentionRate >= 0.7) return AppColors.success;
    if (retentionRate >= 0.5) return AppColors.warning;
    return AppColors.error;
  }

  @override
  Widget build(BuildContext context) {
    final percentage = (retentionRate * 100).toInt();
    final color = _getRetentionColor;

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Retention Rate',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 150,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Background ring
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: 1,
                    strokeWidth: 12,
                    backgroundColor: AppColors.primaryLight,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.primaryLight,
                    ),
                  ),
                ),
                // Progress ring
                SizedBox(
                  width: 140,
                  height: 140,
                  child: CircularProgressIndicator(
                    value: retentionRate,
                    strokeWidth: 12,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
                // Center text
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '$percentage%',
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: color,
                      ),
                    ),
                    Text(
                      'behalten',
                      style: TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Text(
            _getRetentionMessage(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  String _getRetentionMessage() {
    if (retentionRate >= 0.8) return 'Ausgezeichnet! 🌟';
    if (retentionRate >= 0.6) return 'Gut! 👍';
    if (retentionRate >= 0.4) return 'Nicht schlecht';
    return 'Mehr Wiederholung benötigt';
  }
}
