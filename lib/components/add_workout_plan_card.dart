import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/core/constants/constants.dart';

class AddWorkoutPlanCard extends StatelessWidget {
  const AddWorkoutPlanCard({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.push('/workoutPlanslist', extra: ScreenType.select);
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.9,
        padding: EdgeInsets.symmetric(vertical: 40, horizontal: 10),
        decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(8)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 10,
          children: [
            Icon(
              Icons.add,
              size: 40,
            ),
            Text(
              'Add New Workout Plan',
              style: TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
