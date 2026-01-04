import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: Text(
          'Safari Egypt helps you explore the best trips and destinations inside Egypt easily and safely.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
