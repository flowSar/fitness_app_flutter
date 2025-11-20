import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_state.dart';
import 'package:w_allfit/provider/session_provider.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_getting_ready.dart';
import 'package:w_allfit/services/database/FakeDatabase.dart';

class WorkoutPlan extends StatefulWidget {
  final int id;

  const WorkoutPlan({super.key, required this.id});

  @override
  State<WorkoutPlan> createState() => _WorkoutPlanState();
}

class _WorkoutPlanState extends State<WorkoutPlan> {
  @override
  Widget build(BuildContext context) {
    final int sessionId = context.read<SessionProvider>().sessionId;
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrange,
      ),
      body: Column(
        children: [
          Container(
            color: Colors.deepOrange,
            height: MediaQuery.sizeOf(context).height * 0.2,
            width: MediaQuery.sizeOf(context).width,
          ),
          BlocConsumer<WorkoutBloc, WorkoutState>(
            builder: (context, state) {
              if (state is SelectedWorkoutPlan) {
                final List<Map<String, Object>> workoutPlan =
                    state.currentWorkoutPlan;
                return SizedBox(
                  width: MediaQuery.sizeOf(context).width,
                  height: MediaQuery.sizeOf(context).height * 0.6,
                  child: ListView.builder(
                    itemCount: workoutPlan.length,
                    itemBuilder: (context, index) {
                      final exerciseId =
                          workoutPlan[index]['exercise_id'] as int;
                      final exercises = FakeDatabase.exercises[exerciseId - 1];
                      return Column(
                        children: [
                          Text(
                            "${exercises['name']}",
                            style: TextStyle(fontSize: 20),
                          ),
                          Image.asset(
                            "${exercises['image_url']}",
                            height: 160,
                            width: 280,
                            fit: BoxFit.cover,
                            alignment: Alignment.center,
                          ),
                        ],
                      );
                    },
                  ),
                );
              }

              return Text("test");
            },
            listener: (context, state) {},
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 150,
        height: 45,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            context.read<WorkoutBloc>().add(
                StartWorkoutEvent(planId: widget.id, sessionId: sessionId));
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => WorkoutGettingReady(),
                ));
          },
          child: Text("Start"),
        ),
      ),
    ));
  }
}
