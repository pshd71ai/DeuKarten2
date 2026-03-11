import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_service.dart';
import '../services/mock_ai_service.dart';

/// Provider for AIService implementation
/// Currently uses MockAIService for development and testing
final aiServiceProvider = Provider<AIService>((ref) {
  return MockAIService();
});
