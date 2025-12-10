import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/components/button.dart';
import 'package:w_allfit/features/user_workout/data/models/user_plan_model.dart';
import 'package:w_allfit/features/user_workout/presentation/provider/user_workout_provider.dart';

class WorkoutPlanCard extends StatelessWidget {
  final UserPlanModel plan;
  const WorkoutPlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 250, // you can adjust or remove if parent gives height
      clipBehavior: Clip.hardEdge, // ensures borderRadius clips children
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // --- Background Image ---
          Positioned.fill(
            child: Image.network(
              plan.image,
              fit: BoxFit.cover,
            ),
          ),

          // --- Gradient Overlay ---
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.yellow.shade700,
                    Colors.transparent,
                  ],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
              ),
            ),
          ),

          // --- Text + Button (foreground content) ---
          Positioned(
            left: 20,
            right: 20,
            bottom: 10,
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
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black54,
                      ),
                    ],
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Button(
                  onPressed: () {
                    context
                        .read<UserWorkoutProvider>()
                        .updateSelectedPlan(plan);
                    if (plan.sessionsNumber == 1) {}
                    context.push('/workoutPlanSessions');
                  },
                  value: 'Start',
                ),
                SizedBox(height: 6),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
