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
        title: Text(
          'Explore More Plans',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            letterSpacing: -0.3,
          ),
        ),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            SearchBar(
              hintText: 'Search Workouts',
              hintStyle: WidgetStatePropertyAll(
                TextStyle(
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ),
              backgroundColor: WidgetStatePropertyAll(
                isDark ? Colors.grey.shade800 : Colors.grey.shade100,
              ),
              shape: WidgetStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              elevation: WidgetStatePropertyAll(0),
              trailing: [
                Icon(
                  Icons.search,
                  color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                ),
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Workout Programs',
                  style: TextStyle(
                    color: isDark ? Colors.white : Colors.black87,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    letterSpacing: -0.3,
                  ),
                ),
                InkWell(
                  onTap: () {
                    context.push('/workoutPlanslist', extra: {
                      'screentype': ScreenType.display,
                      'plantype': PlanType.program
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'View All',
                          style: TextStyle(
                            color: isDark
                                ? Colors.blue.shade300
                                : Colors.blue.shade700,
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(width: 4),
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: isDark
                              ? Colors.blue.shade300
                              : Colors.blue.shade700,
                        ),
                      ],
                    ),
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
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              'Workout Plans',
                              style: TextStyle(
                                color: isDark ? Colors.white : Colors.black87,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                letterSpacing: -0.3,
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                context.push('/workoutPlanslist', extra: {
                                  'screentype': ScreenType.display,
                                  'plantype': PlanType.quick
                                });
                              },
                              borderRadius: BorderRadius.circular(8),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 4),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'View All',
                                      style: TextStyle(
                                        color: isDark
                                            ? Colors.blue.shade300
                                            : Colors.blue.shade700,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(width: 4),
                                    Icon(
                                      Icons.arrow_forward_ios,
                                      size: 14,
                                      color: isDark
                                          ? Colors.blue.shade300
                                          : Colors.blue.shade700,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 12),
                        Expanded(
                          child: ListView.builder(
                            itemCount: plans.length,
                            padding: const EdgeInsets.only(bottom: 8),
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
                        child: CircularProgressIndicator(
                          strokeWidth: 3,
                          color: isDark ? Colors.white70 : Colors.blue.shade700,
                        ),
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
