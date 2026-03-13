import 'package:freezed_annotation/freezed_annotation.dart';

part 'card_progress.freezed.dart';
part 'card_progress.g.dart';

@freezed
class CardProgress with _$CardProgress {
  const factory CardProgress({
    required String cardId,
    required DateTime createdAt,
    DateTime? lastReviewed,
    DateTime? nextReview,
    
    // SM-2 Algorithm fields
    @Default(0) int repetitions,      // Number of successful reviews (n)
    @Default(2.5) double easeFactor,  // EF - Easiness factor (starts at 2.5)
    @Default(0) int intervalDays,     // Current interval in days (I)
    
    // Quality of response (0-5)
    // 5 - perfect response
    // 4 - correct response after hesitation
    // 3 - correct response recalled with serious difficulty
    // 2 - incorrect response; correct one remembered
    // 1 - incorrect response; correct one seemed easy to recall
    // 0 - complete blackout
    int? lastQuality,
    
    // Statistics
    @Default(0) int totalReviews,
    @Default(0) int correctReviews,
    @Default(0) int consecutiveCorrect,
    
    // Status
    @Default(SRSStatus.newCard) SRSStatus status,
  }) = _CardProgress;
  
  factory CardProgress.fromJson(Map<String, dynamic> json) =>
      _$CardProgressFromJson(json);
}

enum SRSStatus {
  newCard,     // Never studied
  learning,    // In learning phase (first few reviews)
  review,      // In review phase
  mastered,    // High ease factor, long intervals
  suspended,   // Temporarily suspended
}

extension SRSStatusExtension on SRSStatus {
  String get label {
    return switch (this) {
      SRSStatus.newCard => 'Neu',
      SRSStatus.learning => 'Lernen',
      SRSStatus.review => 'Wiederholung',
      SRSStatus.mastered => 'Beherrscht',
      SRSStatus.suspended => 'Pausiert',
    };
  }
}
