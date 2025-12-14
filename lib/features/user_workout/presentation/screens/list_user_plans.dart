import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/components/workout_plan_explore_card.dart';
import 'package:w_allfit/core/constants/constants.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_bloc.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_event.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_state.dart';
import 'package:w_allfit/features/user_workout/data/models/user_plan_model.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plan_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plan_state.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plans_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/components/workout_plan_card.dart';

class ListUserPlans extends StatefulWidget {
  const ListUserPlans({
    super.key,
  });

  @override
  State<ListUserPlans> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<ListUserPlans> {
  late bool processing = false;
  @override
  void initState() {
    context.read<UserPlansBloc>().add(LoadUserPlans());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text('Your Plans'),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            child: Column(
              children: [
                SearchBar(
                  hintText: 'Search Workouts',
                  shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8))),
                  trailing: [
                    Icon(Icons.search),
                  ],
                ),
                SizedBox(
                  height: 14,
                ),
                Expanded(child: BlocBuilder<UserPlansBloc, UserPlansState>(
                  builder: (context, state) {
                    if (state is UserPlansLoading) {
                      return Center(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is UserPlansLoaded) {
                      late List<UserPlanModel> workoutPlans = state.userPlans;

                      return ListView.builder(
                        itemCount: workoutPlans.length,
                        itemBuilder: (context, index) {
                          return SizedBox(
                              height: 180,
                              child:
                                  WorkoutPlanCard(plan: workoutPlans[index]));
                        },
                      );
                    }
                    return Text('empty');
                  },
                )),
              ],
            ),
          ),
        )),
      ],
    );
  }
}
