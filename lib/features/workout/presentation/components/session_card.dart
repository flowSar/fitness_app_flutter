import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:go_router/go_router.dart";
import "package:percent_indicator/flutter_percent_indicator.dart";
import "package:w_allfit/core/utils/functions.dart";
import "package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_bloc.dart";
import "package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_state.dart";
import "package:w_allfit/features/user_workout/presentation/provider/user_workout_provider.dart";
import "package:w_allfit/features/workout/data/models/session_model.dart";

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
    final progress = roundToHalf(widget.session.progress) == 100
        ? 100
        : roundToHalf(widget.session.progress);
    return InkWell(
      onTap: () {
        // update session id
        context.read<UserWorkoutProvider>().updateSessionId(widget.session.id);
        context.push('/userWorkoutPlanSession');
      },
      child: Card(
        elevation: 4,
        child: BlocConsumer<UserWorkoutSessionBloc, UserWorkoutSessionState>(
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
                      percent: widget.session.progress / 100,
                      center: Text(
                        '$progress%',
                      ),
                    ),
            );
          },
        ),
      ),
    );
  }
}
