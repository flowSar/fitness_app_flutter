import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/bloc/workout/workout_bloc.dart';
import 'package:w_allfit/bloc/workout/workout_event.dart';
import 'package:w_allfit/bloc/workout/workout_state.dart';
import 'package:w_allfit/screens/workout/workout_rest.dart';

class WorkoutCounter extends StatefulWidget {
  final int duration;
  final String exerciseName;
  const WorkoutCounter(
      {super.key, required this.duration, required this.exerciseName});

  @override
  State<WorkoutCounter> createState() => _WorkoutCounterState();
}

class _WorkoutCounterState extends State<WorkoutCounter> {
  late int duration = widget.duration;
  late Timer _timer;

  @override
  void dispose() {
    _timer.cancel();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    startCountDown();
    super.initState();
  }

  startCountDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (duration == 0) {
          context.read<WorkoutBloc>().add(NextExerciseEvent());

          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutRest(),
              ));
        }
        duration--;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "${widget.exerciseName}",
          style: TextStyle(
              color: Colors.redAccent,
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        Text(
          "00:${duration}",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        TextButton(
            style: TextButton.styleFrom(
              fixedSize: Size(140, 50),
              backgroundColor:
                  _timer.isActive ? Colors.redAccent : Colors.green,
            ),
            onPressed: () {
              setState(() {
                if (_timer.isActive) {
                  _timer.cancel();
                } else {
                  startCountDown();
                }
              });
            },
            child: Text(
              _timer.isActive ? "PAUSE" : "RESUME",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
            ))
      ],
    );
  }
}
