import 'dart:async';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_state.dart';

class UserWorkoutPrepareScreen extends StatefulWidget {
  const UserWorkoutPrepareScreen({super.key});

  @override
  State<UserWorkoutPrepareScreen> createState() =>
      _WorkoutGetReadyScreenState();
}

class _WorkoutGetReadyScreenState extends State<UserWorkoutPrepareScreen> {
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
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Hello world"),
          duration: Duration(seconds: 3),
        ));
      },
      child: SafeArea(
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
                child: BlocBuilder<UserWorkoutSessionBloc,
                    UserWorkoutSessionState>(
                  builder: (context, state) {
                    if (state is UserWorkoutExerciseInProgress) {
                      return Column(
                        children: [
                          Text(
                            state.exercise.exercise.name,
                            style: TextStyle(
                              color: Colors.blueGrey,
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Image.network(
                            state.exercise.exercise.image
                                .replaceAll('mp4', 'gif'),
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
      )),
    );
  }
}
