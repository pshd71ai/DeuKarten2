import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../models/statistics_model.dart';
import '../widgets/weekly_progress_widget.dart';

// Sample data provider - replace with actual data source
final statisticsProvider =
    StateNotifierProvider<StatisticsNotifier, List<StatisticsModel>>((ref) {
  return StatisticsNotifier();
});

final overallStatisticsProvider = Provider<OverallStatistics>((ref) {
  final statistics = ref.watch(statisticsProvider);
  return StatisticsNotifier.calculateOverallStatistics(statistics);
});

final todayStatisticsProvider = Provider<DailyStatistics>((ref) {
  final statistics = ref.watch(statisticsProvider);
  return StatisticsNotifier.getTodayStatistics(statistics);
});

final weekStatisticsProvider = Provider<List<WeeklyDayData>>((ref) {
  final statistics = ref.watch(statisticsProvider);
  return StatisticsNotifier.getWeekStatistics(statistics);
});

class StatisticsNotifier extends StateNotifier<List<StatisticsModel>> {
  StatisticsNotifier() : super(_generateSampleStatistics());

  void addStatistics(StatisticsModel stats) {
    state = [...state, stats];
  }

  void updateStatistics(StatisticsModel updatedStats) {
    state = state.map((stats) {
      return stats.id == updatedStats.id ? updatedStats : stats;
    }).toList();
  }

  List<StatisticsModel> getStatisticsForDate(DateTime date) {
    return state.where((stats) {
      return stats.date.year == date.year &&
          stats.date.month == date.month &&
          stats.date.day == date.day;
    }).toList();
  }

  List<StatisticsModel> getStatisticsForWeek(DateTime startDate) {
    final endDate = startDate.add(const Duration(days: 7));
    return state.where((stats) {
      return stats.date.isAfter(startDate.subtract(const Duration(days: 1))) &&
          stats.date.isBefore(endDate);
    }).toList();
  }

  List<StatisticsModel> getStatisticsForMonth(int year, int month) {
    return state.where((stats) {
      return stats.date.year == year && stats.date.month == month;
    }).toList();
  }

  static OverallStatistics calculateOverallStatistics(
      List<StatisticsModel> statistics) {
    if (statistics.isEmpty) {
      return OverallStatistics(
        totalCardsLearned: 0,
        totalCardsReviewed: 0,
        totalTestsTaken: 0,
        overallAccuracy: 0.0,
        averageTestScore: 0.0,
        totalStudyTimeMinutes: 0,
        currentStreak: 0,
        longestStreak: 0,
        totalXP: 0,
        retentionRate: 0.0,
      );
    }

    final totalCardsLearned = statistics.fold<int>(
        0, (sum, stats) => sum + stats.cardsLearned);
    final totalCardsReviewed = statistics.fold<int>(
        0, (sum, stats) => sum + stats.cardsReviewed);
    final totalTestsTaken = statistics.fold<int>(
        0, (sum, stats) => sum + stats.testsTaken);
    final averageTestScore = statistics.fold<double>(
            0, (sum, stats) => sum + stats.averageScore) /
        statistics.length;
    final totalStudyTimeMinutes = statistics.fold<int>(
        0, (sum, stats) => sum + stats.studyTimeMinutes);
    final overallAccuracy = totalCardsReviewed > 0
        ? totalCardsLearned / totalCardsReviewed
        : 0.0;
    final totalXP = statistics.fold<int>(
        0, (sum, stats) => sum + stats.xpEarned);
    final totalRetentionCards = statistics.fold<int>(
        0, (sum, stats) => sum + stats.retentionCards);
    final retentionRate = totalCardsReviewed > 0
        ? totalRetentionCards / totalCardsReviewed
        : 0.0;

    // Calculate streaks
    int currentStreak = 0;
    int longestStreak = 0;
    DateTime? lastDate;

    final sortedStats = List<StatisticsModel>.from(statistics)
      ..sort((a, b) => b.date.compareTo(a.date));

    for (final stats in sortedStats) {
      if (lastDate == null ||
          stats.date.difference(lastDate).inDays.abs() == 1) {
        currentStreak++;
        if (currentStreak > longestStreak) {
          longestStreak = currentStreak;
        }
      } else if (stats.date.difference(lastDate).inDays.abs() > 1) {
        currentStreak = 1;
      }
      lastDate = stats.date;
    }

    return OverallStatistics(
      totalCardsLearned: totalCardsLearned,
      totalCardsReviewed: totalCardsReviewed,
      totalTestsTaken: totalTestsTaken,
      overallAccuracy: overallAccuracy,
      averageTestScore: averageTestScore,
      totalStudyTimeMinutes: totalStudyTimeMinutes,
      currentStreak: currentStreak,
      longestStreak: longestStreak,
      lastStudyDate: sortedStats.isNotEmpty ? sortedStats.first.date : null,
      totalXP: totalXP,
      retentionRate: retentionRate,
    );
  }

  static DailyStatistics getTodayStatistics(List<StatisticsModel> statistics) {
    final today = DateTime.now();
    final todayStats = statistics.where((stats) {
      return stats.date.year == today.year &&
          stats.date.month == today.month &&
          stats.date.day == today.day;
    }).toList();

    if (todayStats.isEmpty) {
      return DailyStatistics.empty;
    }

    return DailyStatistics(
      cardsLearned: todayStats.fold(0, (sum, s) => sum + s.cardsLearned),
      testsCompleted: todayStats.fold(0, (sum, s) => sum + s.testsTaken),
      studyMinutes: todayStats.fold(0, (sum, s) => sum + s.studyTimeMinutes),
      xpEarned: todayStats.fold(0, (sum, s) => sum + s.xpEarned),
    );
  }

  static List<WeeklyDayData> getWeekStatistics(List<StatisticsModel> statistics) {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));
    final dayLabels = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];

    final weekData = <WeeklyDayData>[];

    for (int i = 0; i < 7; i++) {
      final dayDate = weekStart.add(Duration(days: i));
      final dayStats = statistics.where((stats) {
        return stats.date.year == dayDate.year &&
            stats.date.month == dayDate.month &&
            stats.date.day == dayDate.day;
      }).toList();

      final value = dayStats.fold(0, (sum, s) => sum + s.cardsLearned);
      final isToday = dayDate.day == now.day &&
          dayDate.month == now.month &&
          dayDate.year == now.year;

      weekData.add(WeeklyDayData(
        dayLabel: dayLabels[i],
        value: value,
        isToday: isToday,
      ));
    }

    return weekData;
  }
}

List<StatisticsModel> _generateSampleStatistics() {
  final now = DateTime.now();
  final dayLabels = ['Mo', 'Di', 'Mi', 'Do', 'Fr', 'Sa', 'So'];
  
  return List.generate(30, (index) {
    final date = now.subtract(Duration(days: index));
    final isToday = index == 0;
    final dayOfWeek = date.weekday;
    
    return StatisticsModel(
      id: 'stats_$index',
      date: date,
      cardsLearned: (index % 3) * 5 + (isToday ? 12 : 5),
      cardsReviewed: (index % 2) * 10 + 10,
      testsTaken: index % 4,
      averageScore: 60.0 + (index % 5) * 8.0,
      studyTimeMinutes: (index % 3) * 10 + 15,
      xpEarned: (index % 2) * 25 + (isToday ? 50 : 25),
      retentionCards: ((index % 3) * 4 + 4),
    );
  });
}
