class CardModel {
  final String id;
  final String german;
  final String english;
  final String? exampleGerman;
  final String? exampleEnglish;
  final String category;
  final int level;
  final DateTime? lastReviewed;
  final int reviewCount;
  final int successCount;

  CardModel({
    required this.id,
    required this.german,
    required this.english,
    this.exampleGerman,
    this.exampleEnglish,
    required this.category,
    this.level = 1,
    this.lastReviewed,
    this.reviewCount = 0,
    this.successCount = 0,
  });

  double get successRate => reviewCount > 0 ? successCount / reviewCount : 0.0;

  CardModel copyWith({
    String? id,
    String? german,
    String? english,
    String? exampleGerman,
    String? exampleEnglish,
    String? category,
    int? level,
    DateTime? lastReviewed,
    int? reviewCount,
    int? successCount,
  }) {
    return CardModel(
      id: id ?? this.id,
      german: german ?? this.german,
      english: english ?? this.english,
      exampleGerman: exampleGerman ?? this.exampleGerman,
      exampleEnglish: exampleEnglish ?? this.exampleEnglish,
      category: category ?? this.category,
      level: level ?? this.level,
      lastReviewed: lastReviewed ?? this.lastReviewed,
      reviewCount: reviewCount ?? this.reviewCount,
      successCount: successCount ?? this.successCount,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'german': german,
      'english': english,
      'exampleGerman': exampleGerman,
      'exampleEnglish': exampleEnglish,
      'category': category,
      'level': level,
      'lastReviewed': lastReviewed?.toIso8601String(),
      'reviewCount': reviewCount,
      'successCount': successCount,
    };
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return CardModel(
      id: json['id'] as String,
      german: json['german'] as String,
      english: json['english'] as String,
      exampleGerman: json['exampleGerman'] as String?,
      exampleEnglish: json['exampleEnglish'] as String?,
      category: json['category'] as String,
      level: json['level'] as int? ?? 1,
      lastReviewed: json['lastReviewed'] != null
          ? DateTime.parse(json['lastReviewed'] as String)
          : null,
      reviewCount: json['reviewCount'] as int? ?? 0,
      successCount: json['successCount'] as int? ?? 0,
    );
  }
}
