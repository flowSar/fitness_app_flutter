import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session_plan/workout_session_plan_bloc.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_prepare_screen.dart';
import '../../../../core/services/database/FakeDatabase.dart';
import '../provider/workout_provider.dart';

class WorkoutPlanSessionScreen extends StatefulWidget {
  final int id;
  const WorkoutPlanSessionScreen({super.key, required this.id});

  @override
  State<WorkoutPlanSessionScreen> createState() => _WorkoutPlanState();
}

class _WorkoutPlanState extends State<WorkoutPlanSessionScreen> {
  late String level = '';
  late String coverImage = '';

  @override
  void initState() {
    final sessionId = context.read<WorkoutProvider>().sessionId;
    final planId = context.read<WorkoutProvider>().planId;
    context
        .read<WorkoutSessionPlanBloc>()
        .add(LoadSessionWorkoutPlan(planId: planId, sessionId: sessionId));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final int sessionId = context.read<WorkoutProvider>().sessionId;
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SafeArea(
        child: Scaffold(
      backgroundColor: isDark ? Colors.white : Colors.white,
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.24,
              width: MediaQuery.sizeOf(context).width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(coverImage),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              color: isDark ? Colors.black87 : Colors.white,
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Text(
                        level,
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('level')
                    ],
                  ),
                  Container(
                    color: Colors.blueGrey,
                    width: 1,
                    height: 40,
                  ),
                  Column(
                    children: [
                      Text(
                        '=142',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('kcal')
                    ],
                  ),
                  Container(
                    color: Colors.blueGrey,
                    width: 1,
                    height: 40,
                  ),
                  Column(
                    children: [
                      Text(
                        '11:52',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text('duration')
                    ],
                  )
                ],
              ),
            ),
            BlocConsumer<WorkoutSessionPlanBloc, SessionWorkoutPlanState>(
              listener: (context, state) {
                if (state is SessionWorkoutPlanLoading) {
                  final plan = state.plan;
                  setState(() {
                    level = plan['level'] as String;
                    coverImage = plan['image'] as String;
                  });
                }
              },
              builder: (context, state) {
                if (state is SessionWorkoutPlanLoading) {
                  final List<Map<String, Object>> workoutPlan =
                      state.workoutPlan;

                  final int duration =
                      workoutPlan[0]['duration_seconds'] as int;
                  return Container(
                    // color: isDark ? Colors.black87 : Colors.white,
                    width: MediaQuery.sizeOf(context).width,
                    height: MediaQuery.sizeOf(context).height * 0.6,
                    padding: EdgeInsets.only(
                        right: 20, left: 20, top: 10, bottom: 100),
                    child: ListView.builder(
                      itemCount: workoutPlan.length,
                      itemBuilder: (context, index) {
                        final exerciseId =
                            workoutPlan[index]['exercise_id'] as int;
                        final exercises =
                            FakeDatabase.exercises[exerciseId - 1];
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "${exercises['name']}",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blueGrey,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Image.asset(
                                    "${exercises['image_url']}",
                                    height: 150,
                                    width: 200,
                                    fit: BoxFit.cover,
                                    alignment: Alignment.center,
                                  ),
                                  Text(
                                    '$duration s',
                                    style: TextStyle(
                                        color: Colors.orange,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ]),
                          ],
                        );
                      },
                    ),
                  );
                }
                return Text("test");
              },
            )
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: 150,
        height: 45,
        child: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          onPressed: () {
            context.push('/workoutPrepare');
          },
          child: Text("Start"),
        ),
      ),
    ));
  }
}
