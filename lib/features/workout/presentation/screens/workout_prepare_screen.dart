import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_state.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';

class WorkoutPrepareScreen extends StatefulWidget {
  const WorkoutPrepareScreen({super.key});

  @override
  State<WorkoutPrepareScreen> createState() => _WorkoutGetReadyScreenState();
}

class _WorkoutGetReadyScreenState extends State<WorkoutPrepareScreen> {
  late Timer _timer;
  late double _progress = 1;
  late int count = 10;
  final player = AudioPlayer();

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startCountDown();

    super.initState();
    // Get the sessionId once without listening
    final sessionId = context.read<WorkoutProvider>().sessionId;

    // Trigger your BLoC event one time
    context
        .read<WorkoutSessionBloc>()
        .add(StartWorkout(sessionId: sessionId, index: 0));
  }

  void startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        count--;
        _progress = count / 10;
        if (count == 4) {
          playCountDown();
        }
        if (count <= 0) {
          _timer.cancel();
          player.pause();
          context.go('/workoutExercise');
        }
      });
    });
  }

  void playCountDown() async {
    await player.play(AssetSource('sounds/clock-countdown.wav'));
  }

  // void playCountDown() async {
  //   await player.play(AssetSource('/sounds/clock-countdown.wav'));
  // }

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
              child: Column(
                spacing: 4,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Get Ready!",
                    style: TextStyle(
                        color: Colors.blueGrey,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    width: 140,
                    height: 140,
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
                ],
              ),
            ),
            Expanded(
              child: BlocBuilder<WorkoutSessionBloc, WorkoutSessionState>(
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
          ],
        ),
      ),
    ));
  }
}
