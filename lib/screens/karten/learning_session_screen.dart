import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LearningSessionScreen extends StatelessWidget {
  const LearningSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Learning Session'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.pop(),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Flashcard Session Placeholder'),
            ElevatedButton(
              onPressed: () => context.go('/karten/result'),
              child: const Text('Finish Session'),
            ),
          ],
        ),
      ),
    );
  }
}
