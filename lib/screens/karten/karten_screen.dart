import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class KartenScreen extends StatelessWidget {
  const KartenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Karten'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Deck List Placeholder'),
            ElevatedButton(
              onPressed: () => context.go('/karten/session?deckId=1'),
              child: const Text('Start Session'),
            ),
          ],
        ),
      ),
    );
  }
}
