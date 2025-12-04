import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/components/full_screen_loading.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_slate.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_event.dart';
import 'package:w_allfit/features/workout/presentation/components/session_card.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';

class WorkoutPlanSessions extends StatefulWidget {
  const WorkoutPlanSessions({super.key});

  @override
  State<WorkoutPlanSessions> createState() => _WorkoutSessionsState();
}

class _WorkoutSessionsState extends State<WorkoutPlanSessions> {
  @override
  void initState() {
    final planId = context.read<WorkoutProvider>().planId;
    final sessionId = context.read<WorkoutProvider>().sessionId;
    context.read<PlanSessionsBloc>().add(LoadPlanSessions(planId: planId));
    context
        .read<WorkoutSessionBloc>()
        .add(UpdateWorkoutSessionProgress(sessionId: sessionId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: EdgeInsets.only(bottom: 10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              BlocBuilder<PlanSessionsBloc, PlanSessionsState>(
                builder: (context, state) {
                  if (state is PlanSessionsLoading) {
                    return FullScreenLoading();
                  }
                  if (state is PlanSessionsLoaded) {
                    final List<Map<String, Object>> sessions =
                        state.planSessions;
                    final plan = state.plan;
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('${plan['image']}'),
                                fit: BoxFit.cover),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(left: 20, bottom: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  '${plan['name']}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 30,
                                      fontWeight: FontWeight.bold,
                                      letterSpacing: 3),
                                ),
                                Text(
                                  "${sessions.length} days left",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: MediaQuery.sizeOf(context).height * 0.7,
                          padding: EdgeInsets.only(bottom: 40),
                          child: ListView.builder(
                            itemCount: sessions.length,
                            itemBuilder: (context, index) {
                              return SessionCard(
                                progress: sessions[index]['progress'] as int,
                                day: index + 1,
                                sessionId: sessions[index]['id'] as int,
                              );
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return Text("failed");
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
