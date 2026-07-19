import 'package:flutter/material.dart';

/// Placeholder until journey persistence lands (Sprint 11).
class SummaryScreen extends StatelessWidget {
  const SummaryScreen({super.key, required this.journeyId});

  final String journeyId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Journey Summary')),
      body: Center(child: Text('Summary for journey $journeyId')),
    );
  }
}
