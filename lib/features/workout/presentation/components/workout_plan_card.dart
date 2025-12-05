import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:percent_indicator/flutter_percent_indicator.dart';
import 'package:w_allfit/features/workout/presentation/components/progress_bar_card.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';

class WorkoutPlanCard extends StatelessWidget {
  final String planImage;
  final String name;
  final int programId;
  const WorkoutPlanCard(
      {super.key,
      required this.planImage,
      required this.name,
      required this.programId});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(planImage),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: EdgeInsets.only(left: 20, bottom: 10, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              name,
              style: TextStyle(
                  color: Colors.white,
                  shadows: [
                    Shadow(
                        offset: Offset(2, 2), // move shadow right & down
                        blurRadius: 4, // how blurry the shadow is
                        color: Colors.black54 // shadow color
                        )
                  ],
                  fontSize: 28,
                  fontWeight: FontWeight.bold),
            ),
            TextButton(
              style: TextButton.styleFrom(
                  fixedSize: Size(120, 40),
                  backgroundColor: Colors.deepOrange,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16))),
              onPressed: () {
                context.read<WorkoutProvider>().updatePlanId(programId);
                context.push('/workoutPlanSessions');
              },
              child: Text(
                "start",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 19,
                    fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 6,
            ),
          ],
        ),
      ),
    );
    ;
  }
}
