import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';

class WeeklyProgressWidget extends StatelessWidget {
  final List<WeeklyDayData> weekData;

  const WeeklyProgressWidget({
    required this.weekData,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (weekData.isEmpty) {
      return const SizedBox.shrink();
    }

    final maxValue = weekData.map((d) => d.value).reduce((a, b) => a > b ? a : b);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Woche gelernt',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: AppColors.primaryLight,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  '${weekData.fold(0, (sum, d) => sum + d.value)} Karten',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          SizedBox(
            height: 120,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: weekData.map((dayData) {
                final height = maxValue > 0 ? (dayData.value / maxValue) * 80 : 0;
                final isMax = dayData.value == maxValue && maxValue > 0;
                final isToday = dayData.isToday;

                return Column(
                  children: [
                    // Value tooltip
                    if (dayData.value > 0)
                      Text(
                        dayData.value.toString(),
                        style: TextStyle(
                          fontSize: 10,
                          color: isToday
                              ? AppColors.primary
                              : AppColors.textSecondary,
                        ),
                      ),
                    const SizedBox(height: 4),
                    // Bar
                    Container(
                      width: 28,
                      height: height.toDouble(),
                      decoration: BoxDecoration(
                        color: isToday
                            ? AppColors.primary
                            : (isMax ? AppColors.secondary : AppColors.primaryLight),
                        borderRadius: BorderRadius.circular(6),
                      ),
                    ),
                    const SizedBox(height: 8),
                    // Day label
                    Text(
                      dayData.dayLabel,
                      style: TextStyle(
                        fontSize: 11,
                        color: isToday
                            ? AppColors.primary
                            : AppColors.textSecondary,
                        fontWeight: isToday ? FontWeight.bold : FontWeight.normal,
                      ),
                    ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class WeeklyDayData {
  final String dayLabel;
  final int value;
  final bool isToday;

  WeeklyDayData({
    required this.dayLabel,
    required this.value,
    this.isToday = false,
  });
}
