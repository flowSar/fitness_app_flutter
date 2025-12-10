import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_plan_session_screen.dart';

class WorkoutLinearCard extends StatelessWidget {
  final Map<String, Object> plan;
  final String sessionId;
  final double? w;
  final double? h;
  const WorkoutLinearCard(
      {super.key, required this.plan, required this.sessionId, this.w, this.h});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // context.read<WorkoutProvider>().updatePlanId(plan['id'].toString());
        // context.read<WorkoutProvider>().updateSessionId(sessionId);
      },
      child: Container(
        width: this.w ?? MediaQuery.sizeOf(context).width * 0.4,
        height: this.h ?? 100,
        margin: const EdgeInsets.all(4),
        clipBehavior: Clip.hardEdge, // ensures borderRadius clips children
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // --- Background Image ---
            Positioned.fill(
              child: Image.asset(
                '${plan['image']}',
                fit: BoxFit.cover,
              ),
            ),

            // --- Gradient Overlay ---
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.yellow.shade600.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // --- Text ---
            Positioned(
              left: 20,
              bottom: 20,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    '${plan['name']}',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      shadows: [
                        Shadow(
                          offset: Offset(2, 2),
                          blurRadius: 4,
                          color: Colors.black54,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
