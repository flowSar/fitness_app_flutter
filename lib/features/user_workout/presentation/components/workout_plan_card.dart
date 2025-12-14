import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/components/button.dart';
import 'package:w_allfit/core/utils/functions.dart';
import 'package:w_allfit/features/user_workout/data/models/user_plan_model.dart';
import 'package:w_allfit/features/user_workout/presentation/provider/user_workout_provider.dart';

class WorkoutPlanCard extends StatelessWidget {
  final UserPlanModel plan;
  const WorkoutPlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.sizeOf(context).width,
      height: 250, // STRICTLY KEPT AT 250
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).brightness == Brightness.dark
                ? const Color.fromRGBO(
                    0, 0, 0, 0.5) // Darker shadow for dark mode
                : const Color.fromRGBO(
                    0, 0, 0, 0.15), // Softer shadow for light mode
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
        // Fallback color if image loads slowly
        color: Theme.of(context).cardColor,
      ),
      child: Stack(
        children: [
          // --- Background Image ---
          Positioned.fill(
            child: Image.network(
              plan.image,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => Container(
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Center(
                    child: Icon(Icons.image_not_supported,
                        size: 50,
                        color: Theme.of(context)
                            .iconTheme
                            .color
                            ?.withOpacity(0.5))),
              ),
            ),
          ),

          // --- Gradient Overlay ---
          Positioned.fill(
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Color.fromRGBO(0, 0, 0, 0.0),
                    Color.fromRGBO(0, 0, 0, 0.6),
                    Color.fromRGBO(0, 0, 0,
                        0.95), // Slightly darker at bottom for text contrast
                  ],
                  stops: [0.0, 0.3, 0.7, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),

          // --- User level / Badge ---
          Positioned(
            top: 16,
            left: 16,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                color: const Color.fromRGBO(0, 0, 0, 0.6),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.white24, width: 0.5),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.fitness_center,
                      color: Colors.orangeAccent, size: 12),
                  const SizedBox(width: 6),
                  Text(
                    plan.level.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // --- Content ---
          Positioned(
            left: 20,
            right: 20,
            bottom: 20,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Title
                Text(
                  plan.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize:
                        18, // Reduced from 22 to prevent intersecting with level badge
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.5,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),

                // Info & Action Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Stats & Progress
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Session Count
                          Row(
                            children: [
                              const Icon(Icons.timer_outlined,
                                  color: Colors.white70, size: 14),
                              const SizedBox(width: 4),
                              Text(
                                "${plan.sessionsNumber} Sessions",
                                style: const TextStyle(
                                    color: Colors.white70,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Progress Bar
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    "Progress",
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 10),
                                  ),
                                  Text(
                                    "${roundToHalf(plan.progress!)}%",
                                    style: const TextStyle(
                                        color: Colors.orangeAccent,
                                        fontSize: 10,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              ClipRRect(
                                borderRadius: BorderRadius.circular(4),
                                child: LinearProgressIndicator(
                                  value: (plan.progress! / 100),
                                  backgroundColor: Colors.white12,
                                  valueColor:
                                      const AlwaysStoppedAnimation<Color>(
                                          Colors.deepOrangeAccent),
                                  minHeight: 4,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 16),

                    // Button
                    Button(
                      onPressed: () {
                        context
                            .read<UserWorkoutProvider>()
                            .updateSelectedPlan(plan);
                        context
                            .read<UserWorkoutProvider>()
                            .updateSelectedPlan(plan);
                        if (plan.sessionsNumber == 1) {}
                        context.push('/userWorkoutPlanSessions');
                      },
                      value: 'Start',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
