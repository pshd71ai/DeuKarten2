class StatisticsModel {
  final String id;
  final DateTime date;
  final int cardsLearned;
  final int cardsReviewed;
  final int testsTaken;
  final double averageScore;
  final int studyTimeMinutes;
  final int xpEarned;
  final int retentionCards; // Cards retained from previous sessions

  StatisticsModel({
    required this.id,
    required this.date,
    this.cardsLearned = 0,
    this.cardsReviewed = 0,
    this.testsTaken = 0,
    this.averageScore = 0.0,
    this.studyTimeMinutes = 0,
    this.xpEarned = 0,
    this.retentionCards = 0,
  });

  double get accuracy => cardsReviewed > 0 ? cardsLearned / cardsReviewed : 0.0;

  double get retentionRate => cardsReviewed > 0 ? retentionCards / cardsReviewed : 0.0;

  StatisticsModel copyWith({
    String? id,
    DateTime? date,
    int? cardsLearned,
    int? cardsReviewed,
    int? testsTaken,
    double? averageScore,
    int? studyTimeMinutes,
    int? xpEarned,
    int? retentionCards,
  }) {
    return StatisticsModel(
      id: id ?? this.id,
      date: date ?? this.date,
      cardsLearned: cardsLearned ?? this.cardsLearned,
      cardsReviewed: cardsReviewed ?? this.cardsReviewed,
      testsTaken: testsTaken ?? this.testsTaken,
      averageScore: averageScore ?? this.averageScore,
      studyTimeMinutes: studyTimeMinutes ?? this.studyTimeMinutes,
      xpEarned: xpEarned ?? this.xpEarned,
      retentionCards: retentionCards ?? this.retentionCards,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'cardsLearned': cardsLearned,
      'cardsReviewed': cardsReviewed,
      'testsTaken': testsTaken,
      'averageScore': averageScore,
      'studyTimeMinutes': studyTimeMinutes,
      'xpEarned': xpEarned,
      'retentionCards': retentionCards,
    };
  }

  factory StatisticsModel.fromJson(Map<String, dynamic> json) {
    return StatisticsModel(
      id: json['id'] as String,
      date: DateTime.parse(json['date'] as String),
      cardsLearned: json['cardsLearned'] as int? ?? 0,
      cardsReviewed: json['cardsReviewed'] as int? ?? 0,
      testsTaken: json['testsTaken'] as int? ?? 0,
      averageScore: json['averageScore'] as double? ?? 0.0,
      studyTimeMinutes: json['studyTimeMinutes'] as int? ?? 0,
      xpEarned: json['xpEarned'] as int? ?? 0,
      retentionCards: json['retentionCards'] as int? ?? 0,
    );
  }
}

class OverallStatistics {
  final int totalCardsLearned;
  final int totalCardsReviewed;
  final int totalTestsTaken;
  final double overallAccuracy;
  final double averageTestScore;
  final int totalStudyTimeMinutes;
  final int currentStreak;
  final int longestStreak;
  final DateTime? lastStudyDate;
  final int totalXP;
  final double retentionRate;

  OverallStatistics({
    required this.totalCardsLearned,
    required this.totalCardsReviewed,
    required this.totalTestsTaken,
    required this.overallAccuracy,
    required this.averageTestScore,
    required this.totalStudyTimeMinutes,
    required this.currentStreak,
    required this.longestStreak,
    this.lastStudyDate,
    this.totalXP = 0,
    this.retentionRate = 0.0,
  });
}

class DailyStatistics {
  final int cardsLearned;
  final int testsCompleted;
  final int studyMinutes;
  final int xpEarned;

  DailyStatistics({
    required this.cardsLearned,
    required this.testsCompleted,
    required this.studyMinutes,
    required this.xpEarned,
  });

  factory DailyStatistics.fromModel(StatisticsModel model) {
    return DailyStatistics(
      cardsLearned: model.cardsLearned,
      testsCompleted: model.testsTaken,
      studyMinutes: model.studyTimeMinutes,
      xpEarned: model.xpEarned,
    );
  }

  static DailyStatistics get empty => DailyStatistics(
        cardsLearned: 0,
        testsCompleted: 0,
        studyMinutes: 0,
        xpEarned: 0,
      );
}
