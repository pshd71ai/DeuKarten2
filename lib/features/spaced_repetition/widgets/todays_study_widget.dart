import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_typography.dart';
import '../providers/today_cards_provider.dart';

class TodaysStudyWidget extends ConsumerWidget {
  const TodaysStudyWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todayCardsAsync = ref.watch(todayCardsProvider);
    
    return todayCardsAsync.when(
      data: (state) {
        final totalCards = state.totalDue;
        
        return GestureDetector(
          onTap: () => context.push('/karten/session'),
          child: Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.primary, AppColors.primaryDark],
              ),
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Heute lernen',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.9),
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '$totalCards Karten bereit',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.play_arrow,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                // Card breakdown
                Row(
                  children: [
                    _buildCardTypeChip(
                      label: 'Neu',
                      count: state.newCards.length,
                      color: Colors.blue,
                    ),
                    const SizedBox(width: 8),
                    _buildCardTypeChip(
                      label: 'Lernen',
                      count: state.learningCards.length,
                      color: Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    _buildCardTypeChip(
                      label: 'Wiederholung',
                      count: state.reviewCards.length,
                      color: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Forecast mini-chart
                _buildForecastChart(state.forecast),
              ],
            ),
          ),
        );
      },
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Fehler beim Laden')),
    );
  }
  
  Widget _buildCardTypeChip({
    required String label,
    required int count,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.5)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 8,
            height: 8,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$label: $count',
            style: TextStyle(
              color: color.withOpacity(0.9),
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
  
  Widget _buildForecastChart(Map<DateTime, int> forecast) {
    if (forecast.isEmpty) {
      return const SizedBox.shrink();
    }
    
    final sortedDates = forecast.keys.toList()..sort();
    final maxValue = forecast.values.isEmpty ? 1 : forecast.values.reduce((a, b) => a > b ? a : b);
    
    return Row(
      children: sortedDates.take(7).map((date) {
        final value = forecast[date] ?? 0;
        final height = maxValue > 0 ? (value / maxValue) * 40 : 0.0;
        final isToday = date.day == DateTime.now().day &&
                       date.month == DateTime.now().month &&
                       date.year == DateTime.now().year;
        
        return Expanded(
          child: Column(
            children: [
              Container(
                height: height,
                margin: const EdgeInsets.symmetric(horizontal: 2),
                decoration: BoxDecoration(
                  color: isToday 
                      ? Colors.white 
                      : Colors.white.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                _getDayLabel(date),
                style: TextStyle(
                  color: Colors.white.withOpacity(0.6),
                  fontSize: 10,
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
  
  String _getDayLabel(DateTime date) {
    final days = ['So', 'Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa'];
    return days[date.weekday % 7];
  }
}
