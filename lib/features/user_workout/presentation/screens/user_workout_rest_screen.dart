import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_state.dart';

class UserWorkoutRestScreen extends StatefulWidget {
  const UserWorkoutRestScreen({super.key});

  @override
  State<UserWorkoutRestScreen> createState() => _WorkoutRestScreenState();
}

class _WorkoutRestScreenState extends State<UserWorkoutRestScreen> {
  late final Timer _timer;
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
  }

  void startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        count--;
        _progress = count / 10;
        if (count == 3) {
          playCountDown();
        }
        if (count <= 0) {
          _timer.cancel();

          context.go('/userWorkoutExercise');
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
    return PopScope(
      onPopInvokedWithResult: (didPop, _) {
        player.pause();
      },
      child: SafeArea(
          child: Scaffold(
        backgroundColor: isDark ? Colors.white : Colors.white,
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
                      "Rest Time!",
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
                      "00:${count < 10 ? '0$count' : '$count'}",
                      style: TextStyle(
                          color: Colors.blueGrey,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: BlocConsumer<UserWorkoutSessionBloc,
                    UserWorkoutSessionState>(
                  listener: (context, state) {
                    if (state is UserWorkoutComplete) {
                      context.go('/userWorkoutComplete');
                    }
                  },
                  builder: (context, state) {
                    if (state is UserWorkoutExerciseInProgress) {
                      return SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Up Next',
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Colors.blue[900],
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              state.exercise.exercise.name,
                              style: TextStyle(
                                color: Colors.blueGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Image.network(
                              state.exercise.exercise.image
                                  .replaceAll('mp4', 'gif'),
                              width: 270,
                              height: 270,
                            ),
                          ],
                        ),
                      );
                    }
                    return Text("");
                  },
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }
}
