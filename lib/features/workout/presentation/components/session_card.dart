import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:w_allfit/features/workout/presentation/bloc/workout_bloc.dart";
import "package:w_allfit/features/workout/presentation/bloc/workout_event.dart";
import "package:w_allfit/features/workout/presentation/bloc/workout_state.dart";
import "package:w_allfit/features/workout/presentation/screens/workout_plan.dart";
import "../../../../core/services/database/FakeDatabase.dart";
import "../provider/workout_provider.dart";

class SessionCard extends StatefulWidget {
  final int day;
  final int sessionId;
  const SessionCard({super.key, required this.day, required this.sessionId});

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  @override
  Widget build(BuildContext context) {
    final session = FakeDatabase.sessions[widget.sessionId - 1];
    late bool sessionComplete = session['complete'] as bool;
    return InkWell(
      onTap: () {
        context
            .read<WorkoutBloc>()
            .add(GetWorkoutPlanEvent(planId: widget.sessionId));
        // update session id
        context.read<WorkoutProvider>().updateSessionId(widget.sessionId);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WorkoutPlan(
            id: widget.sessionId,
          ),
        ));
      },
      child: Card(
        elevation: 4,
        child: BlocConsumer<WorkoutBloc, WorkoutState>(
          listener: (context, state) {
            if (state is SessionComplete) {
              setState(() {
                sessionComplete = true;
              });
            }
          },
          builder: (context, state) {
            return ListTile(
              title: Text(
                'Day ${this.widget.day}',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              subtitle: Text('6 minute left'),
              trailing: sessionComplete
                  ? Text(
                      'Complete',
                      style: TextStyle(color: Colors.green),
                    )
                  : Text('0%'),
            );
          },
        ),
      ),
    );
  }
}
