import 'package:flutter/material.dart';
import 'package:w_allfit/features/nutrition/presentation/nutrition_screen.dart';
import 'package:w_allfit/features/settings/presentation/screens/settings_screen.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_screen.dart';

class BNavigationBar extends StatefulWidget {
  const BNavigationBar({super.key});

  @override
  State<BNavigationBar> createState() => _BNavigationBarState();
}

class _BNavigationBarState extends State<BNavigationBar> {
  late int screenIndex = 0;
  final screens = [
    // Homescreen(),
    WorkoutScreen(),
    NutritionScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndex,
          onTap: (index) {
            print('index: ${index}');
            setState(() {
              screenIndex = index;
            });
          },
          selectedItemColor: Colors.red,
          unselectedItemColor: Colors.deepPurple,
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Training'),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank), label: 'nutrition'),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings), label: "Settings"),
          ]),
    ));
  }
}
