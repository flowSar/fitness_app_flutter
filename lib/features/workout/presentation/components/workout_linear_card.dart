import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';
import 'package:w_allfit/features/workout/presentation/screens/session_workout_plan_screen.dart';

class WorkoutLinearCard extends StatelessWidget {
  final Map<String, Object> plan;
  final int sessionId;
  const WorkoutLinearCard(
      {super.key, required this.plan, required this.sessionId});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        context.read<WorkoutProvider>().updatePlanId(plan['id'] as int);
        context.read<WorkoutProvider>().updateSessionId(sessionId);
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SessionWorkoutPlanScreen(id: sessionId),
            ));
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width * 0.4,
        height: 100,
        margin: EdgeInsets.only(left: 4, right: 4),
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('${plan['image']}'),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20, bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                '${plan['name']}',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
