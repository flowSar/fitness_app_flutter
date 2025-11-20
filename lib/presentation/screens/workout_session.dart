import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path/path.dart';
import 'package:w_allfit/bloc/workout/workout_bloc.dart';
import 'package:w_allfit/bloc/workout/workout_event.dart';
import 'package:w_allfit/bloc/workout/workout_state.dart';
import 'package:w_allfit/components/getting_ready.dart';
import 'package:w_allfit/components/workout_counter.dart';
import 'package:w_allfit/provider/session_provider.dart';
import 'package:w_allfit/screens/workout/congratulation_screen.dart';

class WorkoutSession extends StatefulWidget {
  final int id;
  const WorkoutSession({super.key, required this.id});

  @override
  State<WorkoutSession> createState() => _WorkoutSessionState();
}

class _WorkoutSessionState extends State<WorkoutSession> {
  late int counter = 10;

  @override
  Widget build(BuildContext context) {
    late int sessionId = context.watch<SessionProvider>().id;
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            BlocConsumer<WorkoutBloc, WorkoutState>(
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

                  return Column(
                    children: [
                      Container(
                        color: Colors.grey[100],
                        width: MediaQuery.sizeOf(context).width,
                        height: MediaQuery.sizeOf(context).height * 0.6,
                        child: Column(
                          children: [
                            Image.asset(
                              "${exercise['image_url']}",
                              height: 200,
                              width: MediaQuery.sizeOf(context).width * 0.8,
                              fit: BoxFit.cover,
                            ),
                            Text(
                                "sessionid: ${context.watch<SessionProvider>().id}")
                          ],
                        ),
                      ),
                      WorkoutCounter(
                          duration: 10,
                          exerciseName: exercise['name'] as String)
                    ],
                  );
                }
                return Text("exercise");
              },
            ),
          ],
        ),
      ),
    ));
  }
}
