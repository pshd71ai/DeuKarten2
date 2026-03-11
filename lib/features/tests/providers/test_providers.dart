import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/test_model.dart';
import '../data/mock_tests.dart';

// Sample data provider - replace with actual data source
final testsProvider = StateNotifierProvider<TestsNotifier, List<TestModel>>((ref) {
  return TestsNotifier();
});

class TestsNotifier extends StateNotifier<List<TestModel>> {
  TestsNotifier() : super(mockTests);

  void addTest(TestModel test) {
    state = [...state, test];
  }

  void updateTest(TestModel updatedTest) {
    state = state.map((test) {
      return test.id == updatedTest.id ? updatedTest : test;
    }).toList();
  }

  void deleteTest(String testId) {
    state = state.where((test) => test.id != testId).toList();
  }

  TestModel? getTestById(String testId) {
    try {
      return state.firstWhere((test) => test.id == testId);
    } catch (e) {
      return null;
    }
  }

  List<TestModel> getTestsByCategory(String category) {
    return state.where((test) => test.category == category).toList();
  }
}

// Provider for filtering tests by category
final testsByCategoryProvider = Provider.family<List<TestModel>, String>((ref, category) {
  final tests = ref.watch(testsProvider);
  return tests.where((t) => t.category == category).toList();
});
