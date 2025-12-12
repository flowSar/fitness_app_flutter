import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/components/add_workout_plan_card.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_state.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_bloc.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_event.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_state.dart';
import 'package:w_allfit/features/user_workout/data/models/user_plan_model.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plan_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plan_state.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/quick_start/quick_start_workout_bloc.dart';
import 'package:w_allfit/features/workout/presentation/components/quick_start_card.dart';
import 'package:w_allfit/features/workout/presentation/components/workout_plan_card.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  void initState() {
    context.read<UserPlansBloc>().add(LoadUserPlans());

    context.read<WorkoutPlansBloc>().add(LoadWorkoutPlans());
    final state = context.read<WorkoutPlansBloc>().state;

    if (state is WorkoutPlansLoaded) {
      context
          .read<QuickStartWorkoutBloc>()
          .add(LoadQuickStartWorkoutPlans(workoutPlans: state.workoutPlans));
    }

    // context
    //     .read<PopularPlansBloc>()
    //     .add(LoadPopularPlans(planType: PlanBlocType.popular));
    // context
    //     .read<BeginnerPlansBloc>()
    //     .add(LoadBeginnerPlans(planType: PlanBlocType.beginner));
    // context
    //     .read<AdvancePlansBloc>()
    //     .add(LoadAdvancePlans(planType: PlanBlocType.advanced));
    // context.read<AuthBloc>().add(CheckAuthState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    late List<Widget> wokroutPlancrdStack = [];
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return Column(
                        children: [
                          Text(
                            'Hello, ${state.user?.name}!',
                            style: TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'let\'s workout today',
                            style: TextStyle(color: Colors.grey[500]),
                          ),
                        ],
                      );
                    }

                    return Text('Guest');
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your Plans',
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      spacing: 2,
                      children: [
                        Text('View All'),
                        Icon(Icons.view_list),
                      ],
                    ),
                  )
                ],
              ),

              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                height: 170,
                width: MediaQuery.sizeOf(context).width,
                child: BlocBuilder<UserPlansBloc, UserPlansState>(
                  builder: (context, state) {
                    if (state is UserPlansLoaded) {
                      final List<UserPlanModel> plans = state.userPlans;
                      wokroutPlancrdStack = [];
                      return CarouselSlider.builder(
                        itemCount: plans.length + 1,
                        itemBuilder: (context, index, realIndex) {
                          if (index >= plans.length) {
                            wokroutPlancrdStack.add(AddWorkoutPlanCard());
                          } else {
                            wokroutPlancrdStack.add(WorkoutPlanCard(
                              plan: plans[index],
                            ));
                          }
                          return wokroutPlancrdStack[index];
                        },
                        options: CarouselOptions(
                          height: 200,
                          enableInfiniteScroll: false,
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
                    return SizedBox.shrink();
                  },
                ),
              ),
              // quick start workout
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    'Quick Start',
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.grey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              BlocBuilder<QuickStartWorkoutBloc, QuickStartWorkoutState>(
                builder: (context, state) {
                  if (state is QuickStartWorkoutLoaded) {
                    return Container(
                      margin: EdgeInsets.symmetric(vertical: 6),
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      height: 240,
                      width: MediaQuery.sizeOf(context).width,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          mainAxisExtent: 110,
                          childAspectRatio: 1,
                        ),
                        itemCount: state.workoutPlans.length,
                        itemBuilder: (context, index) {
                          return QuickStartCard(
                            plan: state.workoutPlans[index],
                          );
                        },
                      ),
                    );
                  }
                  return SizedBox();
                },
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Workouts',
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.grey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      spacing: 2,
                      children: [
                        Text('View More'),
                        Icon(Icons.view_list),
                      ],
                    ),
                  )
                ],
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              //   height: 100,
              //   width: MediaQuery.sizeOf(context).width,
              //   child: BlocBuilder<PopularPlansBloc, PlansState>(
              //     builder: (context, state) {
              //       if (state is PlansLoading &&
              //           state.planType == PlanBlocType.popular) {
              //         return CircularProgressIndicator();
              //       }
              //       if (state is PlansLoaded &&
              //           state.planType == PlanBlocType.popular) {
              //         final List<Map<String, Object>> plans = state.plans;
              //         return CarouselSlider.builder(
              //           itemCount: plans.length,
              //           itemBuilder: (context, index, realIndex) {
              //             return WorkoutLinearCard(
              //                 sessionId: '', plan: plans[index]);
              //           },
              //           options: CarouselOptions(
              //               viewportFraction: 0.4, enlargeCenterPage: true),
              //         );
              //       }
              //       return SizedBox(
              //         child: Text("empty"),
              //       );
              //     },
              //   ),
              // ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'beginner Plans',
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.grey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      spacing: 2,
                      children: [
                        Text('View More'),
                        Icon(Icons.view_list),
                      ],
                    ),
                  )
                ],
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              //   height: 100,
              //   width: MediaQuery.sizeOf(context).width,
              //   child: BlocBuilder<BeginnerPlansBloc, PlansState>(
              //     builder: (context, state) {
              //       if (state is PlansLoading &&
              //           state.planType == PlanBlocType.popular) {
              //         return CircularProgressIndicator();
              //       }
              //       if (state is PlansLoaded &&
              //           state.planType == PlanBlocType.beginner) {
              //         final List<Map<String, Object>> plans = state.plans;
              //         return CarouselSlider.builder(
              //           itemCount: plans.length,
              //           itemBuilder: (context, index, realIndex) {
              //             return WorkoutLinearCard(
              //                 sessionId: '', plan: plans[index]);
              //           },
              //           options: CarouselOptions(
              //               viewportFraction: 0.4, enlargeCenterPage: true),
              //         );
              //         ;
              //       }
              //       return SizedBox(
              //         child: Text("empty"),
              //       );
              //     },
              //   ),
              // ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Advanced Plans',
                    style: TextStyle(
                        color: isDark ? Colors.white : Colors.grey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Row(
                      spacing: 2,
                      children: [
                        Text('View More'),
                        Icon(Icons.view_list),
                      ],
                    ),
                  )
                ],
              ),
              // Container(
              //   margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
              //   height: 100,
              //   width: MediaQuery.sizeOf(context).width,
              //   child: BlocBuilder<AdvancePlansBloc, PlansState>(
              //     builder: (context, state) {
              //       if (state is PlansLoading &&
              //           state.planType == PlanBlocType.advanced) {
              //         return CircularProgressIndicator();
              //       }
              //       if (state is PlansLoaded &&
              //           state.planType == PlanBlocType.advanced) {
              //         print("------------advanced ${state.planType}--------");
              //         final List<Map<String, Object>> plans = state.plans;
              //         return CarouselSlider.builder(
              //           itemCount: plans.length,
              //           itemBuilder: (context, index, realIndex) {
              //             return WorkoutLinearCard(
              //                 sessionId: '', plan: plans[index]);
              //           },
              //           options: CarouselOptions(
              //               viewportFraction: 0.4, enlargeCenterPage: true),
              //         );
              //       }
              //       return SizedBox(
              //         child: Text("empty"),
              //       );
              //     },
              //   ),
              // ),
            ],
          ),
        ),
      ),
    ));
  }
}
