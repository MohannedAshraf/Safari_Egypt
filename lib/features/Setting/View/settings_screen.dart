import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Setting')),
      body: ListView(
        children: const [
          ListTile(
            leading: Icon(Icons.dark_mode_outlined),
            title: Text('Dark Mode'),
          ),
          ListTile(
            leading: Icon(Icons.language_outlined),
            title: Text('Language'),
          ),
          ListTile(
            leading: Icon(Icons.notifications_outlined),
            title: Text('Notifications'),
          ),
        ],
      ),
    );
  }
}
