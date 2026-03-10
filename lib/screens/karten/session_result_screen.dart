import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SessionResultScreen extends StatelessWidget {
  const SessionResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Session Results'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Session Results Placeholder'),
            ElevatedButton(
              onPressed: () => context.go('/karten'),
              child: const Text('Back to Decks'),
            ),
          ],
        ),
      ),
    );
  }
}
