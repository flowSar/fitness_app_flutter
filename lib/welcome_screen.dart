import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
        child: Scaffold(
      body: Container(
        width: MediaQuery.sizeOf(context).width,
        height: MediaQuery.sizeOf(context).height,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: isDark
                    ? [Colors.black38, Colors.white12]
                    : [Colors.blue.shade200, Colors.red.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)
            // image: DecorationImage(
            //     image: AssetImage('assets/images/welcom-image.png'),
            //     fit: BoxFit.cover),
            ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "W.AllFit",
              style: TextStyle(fontSize: 60, fontWeight: FontWeight.bold),
            ),
            Text('Transform Your Body'),
            SizedBox(
              height: 60,
            ),
            TextButton(
              style: TextButton.styleFrom(
                backgroundColor: Colors.grey.shade900,
                fixedSize: Size(150, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () {
                setSeenWelcomeScreen();
                context.go('/workoutScreen');
              },
              child: Text(
                "Get Started",
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.black, fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
