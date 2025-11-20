import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_state.dart';
import 'package:w_allfit/features/workout/presentation/screens/congratulation_screen.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_session.dart';

class WorkoutRest extends StatefulWidget {
  const WorkoutRest({super.key});

  @override
  State<WorkoutRest> createState() => _WorkoutRestState();
}

class _WorkoutRestState extends State<WorkoutRest> {
  late int count = 10;
  late Timer _timer;
  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  void initState() {
    startCountingDown();
    super.initState();
  }

  void startCountingDown() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        count--;
        if (count <= 0) {
          _timer.cancel();
          // context.read<WorkoutBloc>().add(MarkExerciseCompleteEvent());
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => WorkoutSession(id: 0),
              ));
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Column(
        children: [
          Container(
            color: Colors.black38,
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.4,
            child: Column(
              children: [
                Text(
                  "Rest",
                  style: TextStyle(fontSize: 20),
                ),
                Text("00:${count}"),
              ],
            ),
          ),
          Container(
            width: MediaQuery.sizeOf(context).width,
            height: MediaQuery.sizeOf(context).height * 0.4,
            color: Colors.white10,
            child: BlocConsumer<WorkoutBloc, WorkoutState>(
              listener: (context, state) {
                if (state is WorkoutComplete) {
                  // context.read<WorkoutBloc>().add(
                  //     MarkWorkouSessionCompleteEvent(sessionId: sessionId));
                  // Delay navigation until after the widget is stable
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => CongratulationScreen()),
                  );
                }
              },
              builder: (context, state) {
                if (state is WorkoutInProgress) {
                  final exercise = state.currentExercise;
                  // final id = currentExercise['exercise_id'] as int;
                  // final exercise = FakeDatabase.exercises[id - 1];
                  return Column(
                    children: [
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${exercise['name']}",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
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
    ));
  }
}
