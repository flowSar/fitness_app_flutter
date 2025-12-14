import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:w_allfit/features/user_workout/data/models/user_plan_model.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_state.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session_plan/user_workout_session_plan_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session_plan/user_workout_session_plan_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session_plan/user_workout_session_plan_state.dart';
import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';
import '../provider/user_workout_provider.dart';

class UserWorkoutPlanSessionScreen extends StatefulWidget {
  const UserWorkoutPlanSessionScreen({super.key});

  @override
  State<UserWorkoutPlanSessionScreen> createState() => _WorkoutPlanState();
}

class _WorkoutPlanState extends State<UserWorkoutPlanSessionScreen> {
  late String level = '';
  late String coverImage = '';
  late UserPlanModel? plan;

  @override
  void initState() {
    final sessionId = context.read<UserWorkoutProvider>().sessionId;

    context
        .read<UserWorkoutSessionPlanBloc>()
        .add(LoadUserSessionWorkoutPlan(sessionId: sessionId));
    plan = context.read<UserWorkoutProvider>().selectedPlan;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
        child: Scaffold(
      backgroundColor: isDark ? Colors.white : Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.20,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(coverImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: isDark ? Colors.black87 : Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        level,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('level')
                    ],
                  ),
                  Container(
                    color: Colors.blueGrey,
                    width: 1,
                    height: 40,
                  ),
                  Column(
                    children: [
                      Text(
                        '=142',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('kcal')
                    ],
                  ),
                  Container(
                    color: Colors.blueGrey,
                    width: 1,
                    height: 40,
                  ),
                  Column(
                    children: [
                      Text(
                        '11:52',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('duration')
                    ],
                  )
                ],
              ),
            ),
            BlocConsumer<UserWorkoutSessionPlanBloc,
                UserWorkoutSessionPlanState>(
              listener: (context, state) {
                if (state is UserSessionWorkoutPlanLoading) {
                  setState(() {
                    level = '${plan?.level}';
                    // level = 'beginner';
                    coverImage = '${plan?.image}';
                  });
                }
                if (state is UserSessionWorkoutPlanLoaded) {
                  context.read<UserWorkoutSessionBloc>().add(StartUserWorkout(
                        index: 0,
                        workoutPlan: state.workoutPlan,
                      ));
                }
              },
              builder: (context, state) {
                if (state is UserSessionWorkoutPlanLoaded) {
                  final List<SessionExerciseModel> workoutPlan =
                      state.workoutPlan;

                  return Container(
                    // color: isDark ? Colors.black87 : Colors.white,
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    padding: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 100),
                    child: ListView.builder(
                      itemCount: workoutPlan.length,
                      itemBuilder: (context, index) {
                        return TimelineTile(
                          indicatorStyle: IndicatorStyle(
                            width: 25,
                            color: Colors.redAccent,
                            iconStyle: IconStyle(
                              color: Colors.white,
                              iconData: Icons.check,
                            ),
                          ),
                          endChild: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 4,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: workoutPlan[index].exercise.name,
                                      style: TextStyle(
                                          fontSize: 20,
                                          color: Colors.blueGrey,
                                          fontWeight: FontWeight.bold),
                                      children: [
                                    TextSpan(
                                      text: workoutPlan[index]
                                                  .exercise
                                                  .duration !=
                                              0
                                          ? ' (${workoutPlan[index].exercise.duration}s)'
                                          : ' (x${workoutPlan[index].exercise.reps})',
                                      style: TextStyle(
                                          color: Colors.redAccent,
                                          fontSize: 16),
                                    )
                                  ])),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Image.network(
                                      workoutPlan[index]
                                          .exercise
                                          .image
                                          .replaceAll('mp4', 'gif'),
                                      height: 150,
                                      width: 200,
                                      fit: BoxFit.cover,
                                      alignment: Alignment.center,
                                    ),
                                  ]),
                            ],
                          ),
                        );
                      },
                    ),
                  );
                }
                if (state is UserWorkoutSessionLoading) {
                  return Center(
                    child: SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return SizedBox.shrink();
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 150,
        height: 45,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            context.push('/userWorkoutPrepare');
          },
          child: Text("Start"),
        ),
      ),
    ));
  }
}
