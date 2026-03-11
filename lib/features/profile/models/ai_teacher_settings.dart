import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_teacher_settings.freezed.dart';
part 'ai_teacher_settings.g.dart';

@freezed
class AITeacherSettings with _$AITeacherSettings {
  const factory AITeacherSettings({
    @Default(true) bool enabled,
    @Default('friendly') String personality,
    @Default(true) bool autoExplainGrammar,
    @Default(true) bool autoCorrectSentences,
    @Default(false) bool autoSpeakResponses,
    @Default(0.7) double ttsSpeed,
    @Default('female') String ttsVoice,
    @Default(true) bool showSuggestions,
    @Default(true) bool trackMistakes,
  }) = _AITeacherSettings;
  
  factory AITeacherSettings.fromJson(Map<String, dynamic> json) =>
      _$AITeacherSettingsFromJson(json);
}
