import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/features/workout/data/models/user_plan_model.dart';
import 'package:w_allfit/features/workout/data/models/session_model.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_slate.dart';
import 'package:w_allfit/features/workout/presentation/components/progress_bar_card.dart';
import 'package:w_allfit/features/workout/presentation/components/session_card.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';

class WorkoutPlanSessions extends StatefulWidget {
  const WorkoutPlanSessions({super.key});

  @override
  State<WorkoutPlanSessions> createState() => _WorkoutSessionsState();
}

class _WorkoutSessionsState extends State<WorkoutPlanSessions> {
  late UserPlanModel plan;
  @override
  void initState() {
    // final sessionId = context.read<WorkoutProvider>().sessionId;

    // context
    //     .read<WorkoutSessionBloc>()
    //     .add(UpdateWorkoutSessionProgress(sessionId: sessionId));
    plan = context.read<WorkoutProvider>().selectedPlan;
    final planId = plan.id;
    context.read<PlanSessionsBloc>().add(LoadPlanSessions(planId: planId));

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
                    return SizedBox(
                      width: MediaQuery.sizeOf(context).width,
                      height: MediaQuery.sizeOf(context).height,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 100,
                            height: 100,
                            child: CircularProgressIndicator(),
                          ),
                        ],
                      ),
                    );
                  }
                  if (state is PlanSessionsLoaded) {
                    final List<SessionModel> sessions = state.planSessions;
                    final completedSessions = sessions
                        .where((session) => session.complete)
                        .toList()
                        .length;
                    final leftSessions = sessions.length - completedSessions;
                    // return Text(plan.image);
                    return Column(
                      children: [
                        Container(
                          width: MediaQuery.sizeOf(context).width,
                          height: 200,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(plan.image),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.only(
                                left: 20, bottom: 20, right: 20),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  plan.name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 3,
                                    shadows: [
                                      Shadow(
                                          color: Colors.black,
                                          offset: Offset(2, 2))
                                    ],
                                  ),
                                ),
                                Text(
                                  "$leftSessions days left",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w400,
                                      shadows: [
                                        Shadow(
                                            color: Colors.black,
                                            offset: Offset(1, 1))
                                      ]),
                                ),
                                ProgressBarCard(progress: plan.progress!),
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
                                session: sessions[index],
                              );
                            },
                          ),
                        )
                      ],
                    );
                  }
                  return Text("Loading failed");
                },
              )
            ],
          ),
        ),
      ),
    ));
  }
}
