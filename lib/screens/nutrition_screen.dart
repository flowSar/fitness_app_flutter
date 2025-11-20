import 'package:flutter/material.dart';

class NutritionScreen extends StatelessWidget {
  const NutritionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Text("nutrition"),
          Image.asset(
            'assets/gif/squat.gif',
            width: 120,
            height: 120,
          ),
        ],
      ),
    ));
  }
}
