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
        height: 160,
        margin: const EdgeInsets.symmetric(vertical: 6),
        clipBehavior: Clip.hardEdge, // ensures borderRadius clips children
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
        ),
        child: Stack(
          children: [
            // --- Background Image ---
            Positioned.fill(
              child: Image.network(
                widget.plan.image,
                fit: BoxFit.cover,
              ),
            ),

            // --- Gradient Overlay ---

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.topRight,
                    colors: [
                      Colors.orange,
                      Colors.transparent,
                    ],
                  ),
                ),
              ),
            ),

            // --- Text & Button ---
            Positioned(
              left: 20,
              right: 20,
              bottom: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    widget.plan.name,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
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
                  const SizedBox(height: 8),
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
