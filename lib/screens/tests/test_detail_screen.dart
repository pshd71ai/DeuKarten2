import 'package:flutter/material.dart';

class TestDetailScreen extends StatelessWidget {
  final String id;
  const TestDetailScreen({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Test Detail: $id'),
      ),
      body: Center(
        child: Text('Details for test $id'),
      ),
    );
  }
}
