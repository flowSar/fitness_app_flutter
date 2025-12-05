import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:percent_indicator/circular_percent_indicator.dart";
import "package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart";
import "package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_state.dart";
import "package:w_allfit/features/workout/presentation/screens/workout_plan_session_screen.dart";
import "../../../../core/services/database/FakeDatabase.dart";
import "../provider/workout_provider.dart";

class SessionCard extends StatefulWidget {
  final int day;
  final int sessionId;
  final int progress;
  const SessionCard(
      {super.key,
      required this.day,
      required this.sessionId,
      required this.progress});

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  @override
  Widget build(BuildContext context) {
    final session = FakeDatabase.sessions[widget.sessionId - 1];
    late bool sessionComplete = session['complete'] as bool;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        // update session id
        context.read<WorkoutProvider>().updateSessionId(widget.sessionId);
        Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => WorkoutPlanSessionScreen(
            id: widget.sessionId,
          ),
        ));
      },
      child: Card(
        elevation: 4,
        child: BlocConsumer<WorkoutSessionBloc, WorkoutSessionState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListTile(
              title: Text(
                'Day ${widget.day}',
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.blueGrey,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text('6 minute left'),
              trailing: sessionComplete
                  ? Text(
                      'Complete',
                      style: TextStyle(color: Colors.green),
                    )
                  : CircularPercentIndicator(
                      radius: 25,
                      lineWidth: 4,
                      percent: widget.progress.toDouble() / 100,
                      center: Text('${widget.progress}%'),
                    ),
            );
          },
        ),
      ),
    );
  }
}
