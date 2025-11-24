import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_state.dart';

class WorkoutExerciseScreen extends StatefulWidget {
  const WorkoutExerciseScreen({super.key});

  @override
  State<WorkoutExerciseScreen> createState() => _WorkoutExerciseScreenState();
}

class _WorkoutExerciseScreenState extends State<WorkoutExerciseScreen> {
  late Timer? _timer;
  late int duration = 10;
  late double _progress = 1;
  late int count = 10;
  final player = AudioPlayer();

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  void initState() {
    // WidgetsBinding.instance.addPostFrameCallback((_) {
    final state = context.read<WorkoutSessionBloc>().state;
    if (state is WorkoutExerciseInProgress) {
      duration = state.sessionExercises['duration_seconds'] as int;
      count = duration;
      startCountDown();
    }
    // });

    super.initState();
  }

  void startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        // if (count > 0) {
        count--;
        // }
        _progress = count / duration;
        if (count == 4) {
          playCountDown();
        }
        if (count <= 0) {
          _timer?.cancel();
          player.pause();
          context.read<WorkoutSessionBloc>().add(NextWorkoutExercise());
          context.go("/workoutRest");
        }
      });
    });
  }

  void playCountDown() async {
    await player.play(AssetSource('sounds/clock-countdown.wav'));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
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
              child: BlocConsumer<WorkoutSessionBloc, WorkoutSessionState>(
                listener: (context, state) {
                  if (state is WorkoutComplete) {
                    context.go('/workoutComplete');
                  }
                },
                builder: (context, state) {
                  if (state is WorkoutExerciseInProgress) {
                    return Column(
                      children: [
                        Text(
                          "${state.exercise['name']}",
                          style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Image.asset(
                          '${state.exercise['image_url']}',
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
              child: Column(
                spacing: 4,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 120,
                    height: 120,
                    child: CircularProgressIndicator(
                      value: _progress,
                      color: Colors.blueGrey,
                      backgroundColor: Colors.black12,
                      strokeWidth: 8,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "00:${count < 10 ? '0${count}' : '${count}'}",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 30,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    spacing: 30,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                          onPressed: () {
                            setState(() {
                              if (_timer!.isActive) {
                                _timer?.cancel();
                              } else {
                                startCountDown();
                              }
                            });
                          },
                          style: TextButton.styleFrom(
                              backgroundColor:
                                  _timer!.isActive ? Colors.red : Colors.green,
                              fixedSize: Size(120, 45)),
                          child: Text(
                            _timer!.isActive ? "Pause" : "Resume",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                      TextButton(
                          onPressed: () {
                            context
                                .read<WorkoutSessionBloc>()
                                .add(NextWorkoutExercise());
                            context.push('/workoutRest');
                          },
                          style: TextButton.styleFrom(
                              backgroundColor: Colors.grey,
                              fixedSize: Size(120, 45)),
                          child: Text(
                            "Next",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
