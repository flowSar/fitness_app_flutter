import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class WorkoutCompleteScreen extends StatelessWidget {
  const WorkoutCompleteScreen({super.key});

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
                  colors: [Colors.black38, Colors.white12],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Amazing Work!",
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              Text(
                "you completed your workout",
                style: TextStyle(fontSize: 18),
              ),
              SizedBox(
                height: 40,
              ),
              TextButton(
                onPressed: () {
                  context.go("/");
                },
                style: TextButton.styleFrom(
                  backgroundColor: isDark ? Colors.white : Colors.grey.shade300,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)),
                  fixedSize: Size(200, 50),
                ),
                child: Text(
                  "Back to Home",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
