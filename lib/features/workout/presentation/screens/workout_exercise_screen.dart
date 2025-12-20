import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/components/count_down_card.dart';
import 'package:w_allfit/components/quit_workout_overlay.dart';
import 'package:w_allfit/components/reps_count_card.dart';
import 'package:w_allfit/core/data/models/exercise_model.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_state.dart';

class WorkoutExerciseScreen extends StatefulWidget {
  const WorkoutExerciseScreen({super.key});

  @override
  State<WorkoutExerciseScreen> createState() => _WorkoutExerciseScreenState();
}

class _WorkoutExerciseScreenState extends State<WorkoutExerciseScreen> {
  late int duration = 0;
  late int reps = 0;
  late String exercisename = '';
  late bool displayQuitOverlay = false;
  @override
  void dispose() {
    super.dispose();
  }

  @override
  void initState() {
    final state = context.read<WorkoutSessionBloc>().state;

    if (state is WorkoutExerciseInProgress) {
      duration = state.exercise.duration;
      reps = state.exercise.reps;
      exercisename = state.exercise.name;
    }
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        setState(() {
          displayQuitOverlay = true;
        });
      },
      child: Stack(
        children: [
          SafeArea(
            child: Scaffold(
              backgroundColor: isDark ? Colors.white : Colors.white,
              appBar: AppBar(
                backgroundColor: Colors.white,
              ),
              body: Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.white, Colors.white60],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child:
                          BlocConsumer<WorkoutSessionBloc, WorkoutSessionState>(
                        listener: (context, state) {
                          if (state is WorkoutComplete) {
                            context.go('/workoutComplete');
                          }
                        },
                        builder: (context, state) {
                          if (state is WorkoutExerciseInProgress) {
                            final ExerciseModel exercise = state.exercise;
                            return Column(
                              children: [
                                Text(
                                  exercise.name,
                                  style: TextStyle(
                                    color: Colors.blueGrey,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Image.network(
                                  exercise.image.replaceAll('mp4', 'gif'),
                                  width: 300,
                                  height: 300,
                                ),
                              ],
                            );
                          }
                          return Text("lodign exercises failed");
                        },
                      ),
                    ),
                    Expanded(
                      child: duration != 0
                          ? CountDownCard(
                              next: () {
                                context
                                    .read<WorkoutSessionBloc>()
                                    .add(NextWorkoutExercise());
                                context.push('/workoutRest');
                              },
                              duration: duration,
                              onCount: (int count) {
                                if (count == 0) {
                                  context
                                      .read<WorkoutSessionBloc>()
                                      .add(NextWorkoutExercise());
                                  context.push('/workoutRest');
                                }
                              },
                            )
                          : RepsCountCard(
                              reps: reps,
                              name: exercisename,
                              next: () {
                                context
                                    .read<WorkoutSessionBloc>()
                                    .add(NextWorkoutExercise());
                                context.push('/workoutRest');
                              },
                              complete: () {
                                context
                                    .read<WorkoutSessionBloc>()
                                    .add(NextWorkoutExercise());
                                Future.delayed(Duration(seconds: 1));
                                context.push('/workoutRest');
                              },
                              previous: () {}),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (displayQuitOverlay)
            _overlayScreen(context, () {
              context.go('/workoutPlanSession');
            }, () {
              setState(() {
                displayQuitOverlay = false;
                // if (_timer == null || !_timer!.isActive) {
                //   startCountDown();
                // }

                // player.resume();
              });
            })
        ],
      ),
    );
  }
}

Widget _overlayScreen(
    BuildContext context, Function onQuit, Function onResume) {
  return SafeArea(
      child: Scaffold(
    backgroundColor: Color.fromRGBO(0, 0, 0, 0.8),
    body: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          spacing: 10,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Are you sure you wanna quit',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 30,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () {
                  onResume();
                },
                child: Text('Resume'),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blueGrey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                onPressed: () => onQuit(),
                child: Text('Quit'),
              ),
            )
          ],
        ),
      ),
    ),
  ));
}
