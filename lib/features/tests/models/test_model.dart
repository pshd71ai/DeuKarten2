import 'question_model.dart';

class TestModel {
  final String id;
  final String title;
  final String description;
  final List<QuestionModel> questions;
  final int duration; // in minutes
  final String category;
  final int? minPassingScore;

  TestModel({
    required this.id,
    required this.title,
    required this.description,
    required this.questions,
    this.duration = 30,
    required this.category,
    this.minPassingScore = 70,
  });

  int get totalQuestions => questions.length;

  TestModel copyWith({
    String? id,
    String? title,
    String? description,
    List<QuestionModel>? questions,
    int? duration,
    String? category,
    int? minPassingScore,
  }) {
    return TestModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      questions: questions ?? this.questions,
      duration: duration ?? this.duration,
      category: category ?? this.category,
      minPassingScore: minPassingScore ?? this.minPassingScore,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'questions': questions.map((q) => q.toJson()).toList(),
      'duration': duration,
      'category': category,
      'minPassingScore': minPassingScore,
    };
  }

  factory TestModel.fromJson(Map<String, dynamic> json) {
    return TestModel(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List)
          .map((q) => QuestionModel.fromJson(q as Map<String, dynamic>))
          .toList(),
      duration: json['duration'] as int? ?? 30,
      category: json['category'] as String,
      minPassingScore: json['minPassingScore'] as int?,
    );
  }
}
