import 'package:flutter/material.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: const [
          ListTile(
            leading: Icon(Icons.question_answer_outlined),
            title: Text('How to book a trip?'),
          ),
          ListTile(
            leading: Icon(Icons.support_agent_outlined),
            title: Text('Contact Support'),
          ),
        ],
      ),
    );
  }
}
