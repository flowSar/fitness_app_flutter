import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
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
import 'package:w_allfit/features/user_workout/presentation/components/workout_plan_card.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/quick_start/quick_start_workout_bloc.dart';
import 'package:w_allfit/features/workout/presentation/components/quick_start_card.dart';

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
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    if (state is Authenticated) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Hello, ${state.user?.name}!',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: theme.colorScheme.onSurface,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Let\'s workout today',
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color:
                                  theme.colorScheme.onSurface.withOpacity(0.6),
                            ),
                          ),
                        ],
                      );
                    }
                    return Text(
                      'Guest',
                      style: theme.textTheme.headlineMedium,
                    );
                  },
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    Intl.message('Your Plans', locale: 'ar'),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      context.go('/listUserPlans');
                    },
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            'View All',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
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

                      return CarouselSlider.builder(
                        itemCount: plans.length + 1,
                        itemBuilder: (context, index, realIndex) {
                          if (index == plans.length) {
                            return const AddWorkoutPlanCard();
                          }

                          return WorkoutPlanCard(
                            plan: plans[index],
                          );
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
              const SizedBox(height: 20),
              Row(
                children: [
                  Text(
                    'Quick Start',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Popular Workouts',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            'View More',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Beginner Plans',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            'View More',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
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
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Advanced Plans',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: theme.colorScheme.onSurface,
                    ),
                  ),
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      child: Row(
                        children: [
                          Text(
                            'View More',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.colorScheme.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 4),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 14,
                            color: theme.colorScheme.primary,
                          ),
                        ],
                      ),
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
    );
  }
}
