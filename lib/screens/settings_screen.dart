import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    print('--------------------------settings-------------');

    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 6, vertical: 6),
        child: Column(
          children: [Text("Settings")],
        ),
      ),
    ));
  }
}
