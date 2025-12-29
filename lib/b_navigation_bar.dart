import 'package:flutter/material.dart';
import 'package:w_allfit/features/explore/presentation/screens/explore_screen.dart';
import 'package:w_allfit/features/nutrition/presentation/nutrition_screen.dart';
import 'package:w_allfit/features/settings/presentation/screens/settings_screen.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_screen.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class BNavigationBar extends StatefulWidget {
  const BNavigationBar({super.key});

  @override
  State<BNavigationBar> createState() => _BNavigationBarState();
}

class _BNavigationBarState extends State<BNavigationBar> {
  late int screenIndex = 0;
  final screens = [
    WorkoutScreen(),
    ExploreScreen(),
    NutritionScreen(),
    SettingsScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
        child: Scaffold(
      body: screens[screenIndex],
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: screenIndex,
          onTap: (index) {
            setState(() {
              screenIndex = index;
            });
          },
          selectedItemColor: isDark ? Colors.white : Colors.red,
          unselectedItemColor: isDark ? Colors.grey : Colors.deepPurple,
          showUnselectedLabels: true,
          items: [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: AppLocalizations.of(context)!.training),
            BottomNavigationBarItem(
                icon: Icon(Icons.explore),
                label: AppLocalizations.of(context)!.explore),
            BottomNavigationBarItem(
                icon: Icon(Icons.food_bank),
                label: AppLocalizations.of(context)!.nutrition),
            BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: AppLocalizations.of(context)!.settings),
          ]),
    ));
  }
}
