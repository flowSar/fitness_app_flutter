import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/components/workout_plan_explore_card.dart';
import 'package:w_allfit/core/constants/constants.dart';
import 'package:w_allfit/core/constants/plansType.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_bloc.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_event.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_state.dart';

class WorkoutPlansListScreen extends StatefulWidget {
  final ScreenType? screenType;
  final PlanType? planType;
  const WorkoutPlansListScreen(
      {super.key,
      this.screenType = ScreenType.display,
      this.planType = PlanType.program});

  @override
  State<WorkoutPlansListScreen> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<WorkoutPlansListScreen> {
  late bool processing = false;
  @override
  void initState() {
    context.read<WorkoutPlansBloc>().add(LoadWorkoutPlans());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitle = widget.screenType == ScreenType.select
        ? 'Select Workout Plan'
        : 'All Workout Plans';

    return Stack(
      children: [
        SafeArea(
            child: Scaffold(
          appBar: AppBar(
            title: Text(appBarTitle),
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
                Expanded(
                    child: BlocBuilder<WorkoutPlansBloc, WorkoutPlansState>(
                  builder: (context, state) {
                    if (state is WorkoutPlansLoading) {
                      return Center(
                        child: SizedBox(
                          width: 80,
                          height: 80,
                          child: CircularProgressIndicator(),
                        ),
                      );
                    }
                    if (state is WorkoutPlansLoaded) {
                      late List<PlanModel> workoutPlans = [];
                      if (widget.planType == PlanType.program) {
                        workoutPlans = state.workoutPrograms;
                      } else {
                        workoutPlans = state.workoutPlans;
                      }

                      return ListView.builder(
                        itemCount: workoutPlans.length,
                        itemBuilder: (context, index) {
                          return WorkoutPlanExploreCard(
                            plan: workoutPlans[index],
                            screenType: widget.screenType!,
                            processing: (value) {
                              setState(() {
                                processing = value;
                              });
                            },
                          );
                        },
                      );
                    }
                    return Text('empty');
                  },
                )),
              ],
            ),
          ),
          floatingActionButton: ScreenType.select == ScreenType.select
              ? Material(
                  color: Colors.transparent,
                  elevation: 4,
                  child: InkWell(
                    onTap: () {
                      context.push('/createWorkoutPlan');
                    },
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 24, vertical: 14),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromRGBO(255, 76, 76, 1.0),
                            Color.fromRGBO(255, 100, 100, 1.0),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Create new Plan',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.add,
                            color: Colors.white,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              : null,
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        )),
        if (processing) _loadingOverlay(context),
        // Container(
        //   color: Color.fromRGBO(44, 38, 38, 0.8),
        //   child: Center(
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         SizedBox(
        //           width: 100,
        //           height: 100,
        //           child: CircularProgressIndicator(),
        //         ),
        //         SizedBox(
        //           height: 10,
        //         ),
        //         Text('preparing plan',
        //             style: TextStyle(
        //                 color: Colors.white,
        //                 fontSize: 18,
        //                 decoration: TextDecoration.none,
        //                 fontWeight: FontWeight.w500,
        //                 fontFamily: 'roboto'))
        //       ],
        //     ),
        //   ),
        // ),
      ],
    );
  }
}

Widget _loadingOverlay(BuildContext context) {
  return Container(
    color: Color.fromRGBO(44, 38, 38, 0.8),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: 100,
            height: 100,
            child: CircularProgressIndicator(),
          ),
          SizedBox(
            height: 10,
          ),
          Text('preparing plan',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  decoration: TextDecoration.none,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'roboto'))
        ],
      ),
    ),
  );
}
