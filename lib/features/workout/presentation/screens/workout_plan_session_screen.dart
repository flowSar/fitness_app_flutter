import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/workout/data/models/exercise_model.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_state.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';

class WorkoutPlanSessionScreen extends StatefulWidget {
  const WorkoutPlanSessionScreen({super.key});

  @override
  State<WorkoutPlanSessionScreen> createState() => _WorkoutPlanState();
}

class _WorkoutPlanState extends State<WorkoutPlanSessionScreen> {
  late String level = '';
  late String coverImage = '';
  late PlanModel? plan;

  @override
  void initState() {
    plan = context.read<WorkoutProvider>().selectedPlan;
    context
        .read<WorkoutSessionBloc>()
        .add(LoadWorkoutSession(planId: plan!.id));
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
              height: MediaQuery.sizeOf(context).height * 0.24,
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
            BlocConsumer<WorkoutSessionBloc, WorkoutSessionState>(
              listener: (context, state) {
                if (state is WorkoutSessionLoading) {
                  setState(() {
                    level = '${plan?.level}';
                    // level = 'beginner';
                    coverImage = '${plan?.image}';
                  });
                }
              },
              builder: (context, state) {
                if (state is WorkoutSessionLoaded) {
                  final List<ExerciseModel> exercises = state.exercises;

                  return Container(
                    // color: isDark ? Colors.black87 : Colors.white,
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.64,
                    padding: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 100),
                    child: ListView.builder(
                      itemCount: exercises.length,
                      itemBuilder: (context, index) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 4,
                            ),
                            RichText(
                                text: TextSpan(
                                    text: exercises[index].name,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.blueGrey,
                                        fontWeight: FontWeight.bold),
                                    children: [
                                  TextSpan(
                                    text: exercises[index].duration != 0
                                        ? ' (${exercises[index].duration}s)'
                                        : ' (x${exercises[index].reps})',
                                    style: TextStyle(
                                        color: Colors.redAccent, fontSize: 16),
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
                                    exercises[index]
                                        .image
                                        .replaceAll('mp4', 'gif'),
                                    height: 150,
                                    width: 200,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                ]),
                          ],
                        );
                      },
                    ),
                  );
                }
                if (state is WorkoutSessionLoading) {
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
            context.push('/workoutPrepare');
          },
          child: Text("Start"),
        ),
      ),
    ));
  }
}
