import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/core/constants/constants.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plan_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plan_state.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plans_bloc.dart';

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
            content: Text('created plan failed ${state.error}'),
            duration: Duration(seconds: 3),
          ));
        }
        if (state is UserPlanAddedSuccess) {
          widget.processing!(false);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text('created successfully'),
            duration: Duration(seconds: 3),
          ));
        }
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 6),
        width: MediaQuery.sizeOf(context).width,
        height: 160,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: NetworkImage(widget.plan.image),
            fit: BoxFit.cover,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: EdgeInsets.only(left: 20, bottom: 10, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                widget.plan.name,
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
                  if (widget.screenType == ScreenType.select) {
                    widget.processing!(true);
                    context
                        .read<UserPlansBloc>()
                        .add(AddUserPlanEvent(planId: widget.plan.id));
                  }
                },
                child: Text(
                  btnTitle,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
