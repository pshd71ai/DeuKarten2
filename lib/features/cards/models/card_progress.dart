class CardProgress {
  final String cardId;
  final int repetitions;
  final double easeFactor;
  final int intervalDays;
  final DateTime? lastReviewedAt;
  final DateTime? nextReviewAt;

  const CardProgress({
    required this.cardId,
    required this.repetitions,
    required this.easeFactor,
    required this.intervalDays,
    required this.lastReviewedAt,
    required this.nextReviewAt,
  });

  CardProgress copyWith({
    String? cardId,
    int? repetitions,
    double? easeFactor,
    int? intervalDays,
    DateTime? lastReviewedAt,
    DateTime? nextReviewAt,
  }) {
    return CardProgress(
      cardId: cardId ?? this.cardId,
      repetitions: repetitions ?? this.repetitions,
      easeFactor: easeFactor ?? this.easeFactor,
      intervalDays: intervalDays ?? this.intervalDays,
      lastReviewedAt: lastReviewedAt ?? this.lastReviewedAt,
      nextReviewAt: nextReviewAt ?? this.nextReviewAt,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cardId': cardId,
      'repetitions': repetitions,
      'easeFactor': easeFactor,
      'intervalDays': intervalDays,
      'lastReviewedAt': lastReviewedAt?.toIso8601String(),
      'nextReviewAt': nextReviewAt?.toIso8601String(),
    };
  }

  factory CardProgress.fromJson(Map<String, dynamic> json) {
    return CardProgress(
      cardId: json['cardId'] as String,
      repetitions: json['repetitions'] as int? ?? 0,
      easeFactor: (json['easeFactor'] as num?)?.toDouble() ?? 2.5,
      intervalDays: json['intervalDays'] as int? ?? 0,
      lastReviewedAt: json['lastReviewedAt'] != null
          ? DateTime.parse(json['lastReviewedAt'] as String)
          : null,
      nextReviewAt: json['nextReviewAt'] != null
          ? DateTime.parse(json['nextReviewAt'] as String)
          : null,
    );
  }
}
