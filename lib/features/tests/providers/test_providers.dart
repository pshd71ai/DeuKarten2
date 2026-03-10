import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/test_model.dart';

// Sample data provider - replace with actual data source
final testsProvider = StateNotifierProvider<TestsNotifier, List<TestModel>>((ref) {
  return TestsNotifier();
});

class TestsNotifier extends StateNotifier<List<TestModel>> {
  TestsNotifier() : super(_sampleTests);

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
    return state.firstWhere((test) => test.id == testId);
  }

  List<TestModel> getTestsByCategory(String category) {
    return state.where((test) => test.category == category).toList();
  }
}

final _sampleTests = <TestModel>[
  TestModel(
    id: '1',
    title: 'German Greetings',
    description: 'Test your knowledge of common German greetings',
    duration: 10,
    category: 'Beginner',
    minPassingScore: 70,
    questions: [],
  ),
  TestModel(
    id: '2',
    title: 'Basic Vocabulary',
    description: 'Essential German words and phrases',
    duration: 20,
    category: 'Beginner',
    minPassingScore: 70,
    questions: [],
  ),
  TestModel(
    id: '3',
    title: 'German Grammar',
    description: 'Test your understanding of German grammar rules',
    duration: 30,
    category: 'Intermediate',
    minPassingScore: 70,
    questions: [],
  ),
];
