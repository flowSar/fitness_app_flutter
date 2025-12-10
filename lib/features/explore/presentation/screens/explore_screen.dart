import 'package:carousel_slider/carousel_slider.dart';
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
import 'package:w_allfit/features/workout/presentation/bloc/home/quick_start/quick_start_workout_bloc.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  void initState() {
    context.read<WorkoutPlansBloc>().add(LoadWorkoutPlans());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        title: Text('Explore More Plans'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            SearchBar(
              hintText: 'Search Workouts',
              shape: WidgetStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              )),
              trailing: [Icon(Icons.search)],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Workout Programs',
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () {
                    context.push('/workoutPlanslist', extra: {
                      'screentype': ScreenType.display,
                      'plantype': PlanType.program
                    });
                  },
                  child: Row(
                    spacing: 2,
                    children: [
                      Text('View All'),
                      Icon(Icons.list),
                    ],
                  ),
                )
              ],
            ),
            Expanded(
              child: BlocConsumer<WorkoutPlansBloc, WorkoutPlansState>(
                listener: (context, state) {
                  if (state is WorkoutPlansLoaded) {
                    context.read<QuickStartWorkoutBloc>().add(
                        LoadQuickStartWorkoutPlans(
                            workoutPlans: state.workoutPlans));
                  }
                },
                builder: (context, state) {
                  if (state is WorkoutPlansLoaded) {
                    final List<PlanModel> programs = state.workoutPrograms;
                    final List<PlanModel> plans = state.workoutPlans;
                    return Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        SizedBox(
                          height: 180,
                          child: CarouselSlider.builder(
                            itemCount: programs.length,
                            itemBuilder: (context, index, realIndex) {
                              // return Text('${plans[index].name}');
                              return WorkoutPlanExploreCard(
                                plan: programs[index],
                                screenType: ScreenType.display,
                              );
                            },
                            options: CarouselOptions(
                              height: 170,
                              // enableInfiniteScroll: false,
                              enlargeCenterPage: true,
                              aspectRatio: 16 / 9,
                              viewportFraction: 0.8,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Workout Plans',
                              style: TextStyle(
                                  color:
                                      isDark ? Colors.white : Colors.grey[800],
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700),
                            ),
                            InkWell(
                              onTap: () {
                                context.push('/workoutPlanslist', extra: {
                                  'screentype': ScreenType.display,
                                  'plantype': PlanType.quick
                                });
                              },
                              child: Row(
                                spacing: 2,
                                children: [
                                  Text('View All'),
                                  Icon(Icons.list),
                                ],
                              ),
                            )
                          ],
                        ),
                        Expanded(
                          child: ListView.builder(
                            itemCount: plans.length,
                            // shrinkWrap: true,
                            itemBuilder: (context, index) {
                              return WorkoutPlanExploreCard(
                                plan: plans[index],
                                screenType: ScreenType.display,
                              );
                            },
                          ),
                        )
                      ],
                    );
                  }
                  if (state is WorkoutPlansLoading) {
                    return Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
