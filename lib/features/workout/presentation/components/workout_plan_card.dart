import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/features/workout/data/models/plan_model.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';

class WorkoutPlanCard extends StatelessWidget {
  final PlanModel plan;
  const WorkoutPlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage(plan.image),
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
              plan.name,
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
                context.read<WorkoutProvider>().updateSelectedPlan(plan);
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
