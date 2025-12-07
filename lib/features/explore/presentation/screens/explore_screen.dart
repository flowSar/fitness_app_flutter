import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/components/workout_plan_explore_card.dart';
import 'package:w_allfit/core/constants/constants.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_bloc.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_event.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_state.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plan_state.dart';

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
                  'Workout Plans',
                  style: TextStyle(
                      color: isDark ? Colors.white : Colors.grey[800],
                      fontSize: 16,
                      fontWeight: FontWeight.w700),
                ),
                InkWell(
                  onTap: () {
                    context.push('/workoutPlanslist',
                        extra: ScreenType.display);
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
            Container(
              margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
              height: 170,
              width: MediaQuery.sizeOf(context).width,
              child: BlocBuilder<WorkoutPlansBloc, WorkoutPlansState>(
                builder: (context, state) {
                  if (state is WorkoutPlansLoaded) {
                    final List<PlanModel> plans = state.workoutPlans;

                    return CarouselSlider.builder(
                      itemCount: plans.length,
                      itemBuilder: (context, index, realIndex) {
                        // return Text('${plans[index].name}');
                        return WorkoutPlanExploreCard(
                          plan: plans[index],
                          screenType: ScreenType.display,
                        );
                      },
                      options: CarouselOptions(
                        height: 200,
                        // enableInfiniteScroll: false,
                        enlargeCenterPage: true,
                        aspectRatio: 16 / 9,
                        viewportFraction: 0.8,
                      ),
                    );
                  }
                  if (state is UserPlansLoading) {
                    return Center(
                      child: SizedBox(
                        width: 60,
                        height: 60,
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                  return SizedBox(
                    width: MediaQuery.sizeOf(context).width * 0.9,
                    height: 120,
                    child: Text("Select New Plan"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
