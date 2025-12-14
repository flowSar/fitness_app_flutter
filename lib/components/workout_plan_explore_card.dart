import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/components/button.dart';
import 'package:w_allfit/core/constants/constants.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plan_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plan_state.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plans_bloc.dart';

class WorkoutPlanExploreCard extends StatefulWidget {
  final PlanModel plan;
  final ScreenType screenType;
  final Function(bool value)? processing;
  const WorkoutPlanExploreCard(
      {super.key,
      required this.plan,
      required this.screenType,
      this.processing});

  @override
  State<WorkoutPlanExploreCard> createState() => _WorkoutPlanExploreCardState();
}

class _WorkoutPlanExploreCardState extends State<WorkoutPlanExploreCard> {
  @override
  Widget build(BuildContext context) {
    final String btnTitle =
        widget.screenType == ScreenType.select ? 'Select' : 'Preview';
    return BlocListener<UserPlansBloc, UserPlansState>(
      listener: (context, state) {
        if (state is UserPlanAdding) {
          widget.processing!(true);
        }
        if (state is UserPlanAddedFailure) {
          widget.processing!(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Created plan failed: ${state.error}'),
            duration: Duration(seconds: 3),
          ));
        }
        if (state is UserPlanAddedSuccess) {
          widget.processing!(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('Created successfully'),
            duration: Duration(seconds: 3),
          ));
        }
      },
      child: Container(
        width: MediaQuery.sizeOf(context).width,
        height: 220, // Increased height for better aspect ratio
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 4),
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20), // More rounded corners
          boxShadow: [
            const BoxShadow(
              color: Color.fromRGBO(0, 0, 0, 0.15),
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Stack(
          children: [
            // --- Background Image ---
            Positioned.fill(
              child: Image.network(
                widget.plan.image,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey.shade300,
                  child: const Center(
                      child: Icon(Icons.image_not_supported,
                          size: 50, color: Colors.grey)),
                ),
              ),
            ),

            // --- Gradient Overlay (Improved visibility) ---
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: const [
                      Colors.transparent,
                      Color.fromRGBO(0, 0, 0, 0.0),
                      Color.fromRGBO(0, 0, 0, 0.4),
                      Color.fromRGBO(0, 0, 0, 0.8),
                    ],
                    stops: const [0.0, 0.5, 0.8, 1.0],
                  ),
                ),
              ),
            ),

            // --- Level Badge ---
            Positioned(
              top: 16,
              left: 16,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: const Color.fromRGBO(0, 0, 0, 0.6),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.white24, width: 0.5),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.fitness_center,
                        color: Colors.orangeAccent, size: 14),
                    const SizedBox(width: 6),
                    Text(
                      widget.plan.level.toUpperCase(),
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
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text Info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          widget.plan.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.w800,
                            letterSpacing: -0.5,
                            height: 1.1,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Row(
                          children: [
                            const Icon(Icons.timer_outlined,
                                color: Colors.white70, size: 14),
                            const SizedBox(width: 4),
                            Text(
                              "${widget.plan.sessionsNumber} Sessions",
                              style: const TextStyle(
                                  color: Colors.white70, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 16),
                  // Action Button
                  Button(
                    onPressed: () {
                      if (widget.screenType == ScreenType.select) {
                        widget.processing!(true);
                        context
                            .read<UserPlansBloc>()
                            .add(AddUserPlanEvent(planId: widget.plan.id));
                      }
                    },
                    value: btnTitle,
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
