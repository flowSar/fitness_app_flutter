import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:percent_indicator/flutter_percent_indicator.dart";
import "package:w_allfit/features/workout/data/models/session_model.dart";
import "package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart";
import "package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_state.dart";
import "package:w_allfit/features/workout/presentation/provider/workout_provider.dart";

class SessionCard extends StatefulWidget {
  final SessionModel session;
  const SessionCard({super.key, required this.session});

  @override
  State<SessionCard> createState() => _SessionCardState();
}

class _SessionCardState extends State<SessionCard> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return InkWell(
      onTap: () {
        // update session id
        context.read<WorkoutProvider>().updateSessionId(widget.session.id);
        // Navigator.of(context).push(MaterialPageRoute(
        //   builder: (context) => WorkoutPlanSessionScreen(
        //     id: widget.sessionId,
        //   ),
        // ));
      },
      child: Card(
        elevation: 4,
        child: BlocConsumer<WorkoutSessionBloc, WorkoutSessionState>(
          listener: (context, state) {},
          builder: (context, state) {
            return ListTile(
              title: Text(
                widget.session.name,
                style: TextStyle(
                    color: isDark ? Colors.white : Colors.blueGrey,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
              subtitle: Text('6 minute left'),
              trailing: widget.session.complete
                  ? Text(
                      'Complete',
                      style: TextStyle(color: Colors.green),
                    )
                  :
                  // : Text('uncomplete'),
                  CircularPercentIndicator(
                      radius: 25,
                      lineWidth: 4,
                      percent: widget.session.progress,
                      center: Text(
                        '${widget.session.progress}%',
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
