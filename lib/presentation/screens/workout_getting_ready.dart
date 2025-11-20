import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/bloc/workout/workout_bloc.dart';
import 'package:w_allfit/bloc/workout/workout_event.dart';
import 'package:w_allfit/bloc/workout/workout_state.dart';
import 'package:w_allfit/screens/workout/workout_session.dart';

class WorkoutGettingReady extends StatefulWidget {
  const WorkoutGettingReady({super.key});

  @override
  State<WorkoutGettingReady> createState() => _WorkoutGettingReadyState();
}

class _WorkoutGettingReadyState extends State<WorkoutGettingReady> {
  late int duration = 10;
  late double _progress = 10;
  late Timer _timer;

  @override
  void initState() {
    startCounDown();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void startCounDown() {
    _timer = Timer.periodic(
      Duration(seconds: 1),
      (timer) {
        setState(() {
          duration--;
          _progress = duration / 10;
          if (duration <= 0) {
            _timer.cancel();
          }
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 20),
              child: Container(
                color: Colors.white12,
                width: MediaQuery.sizeOf(context).width,
                height: MediaQuery.sizeOf(context).height * 0.4,
                child: Column(
                  children: [
                    Text(
                      "Ready TO GO",
                      style: TextStyle(
                          color: Colors.redAccent,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: 100,
                      height: 100,
                      child: CircularProgressIndicator(
                        value: _progress,
                        color: Colors.red,
                        strokeWidth: 8,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      '00:${duration < 10 ? '0${duration}' : duration}',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkoutSession(id: 0),
                              ));
                        },
                        child: Text("Next")),
                  ],
                ),
              ),
            ),
            Container(
              color: Colors.white12,
              width: MediaQuery.sizeOf(context).width,
              height: MediaQuery.sizeOf(context).height * 0.4,
              child: BlocBuilder<WorkoutBloc, WorkoutState>(
                builder: (context, state) {
                  if (state is WorkoutInProgress) {
                    final exercise = state.currentExercise;
                    return Column(
                      children: [
                        Text(
                          '${exercise['name']}',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Image.asset(
                          "${exercise['image_url']}",
                          height: 200,
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          fit: BoxFit.cover,
                        ),
                      ],
                    );
                  }

                  return SizedBox();
                },
              ),
            )
          ],
        ),
      ),
    ));
  }
}
