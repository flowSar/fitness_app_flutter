import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/popular_plans/popular_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_event.dart';
import 'package:w_allfit/features/workout/presentation/components/quick_start_card.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';
import 'package:w_allfit/features/workout/presentation/screens/plan_sessions.dart';

class WorkoutScreen extends StatefulWidget {
  const WorkoutScreen({super.key});

  @override
  State<WorkoutScreen> createState() => _WorkoutScreenState();
}

class _WorkoutScreenState extends State<WorkoutScreen> {
  @override
  void initState() {
    context.read<PopularPlansBloc>().add(LoadPopularPlans());
    context.read<UserPlansBloc>().add(LoadUserPlans());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    context.read<WorkoutBloc>().add(LoadPrograms());
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 16),
                child: Column(
                  children: [
                    Text(
                      'Hello, Sarah!',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'let\'s workout today',
                      style: TextStyle(color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Text(
                    'Your Plans',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 6),
                height: 170,
                child: BlocBuilder<UserPlansBloc, UserPlansState>(
                  builder: (context, state) {
                    if (state is UserPlansLoading) {
                      print('----------------------------');
                    }
                    if (state is UserPlansLoading) {
                      final List<Map<String, Object>> programs =
                          state.userPlans;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: programs.length,
                        itemBuilder: (context, index) {
                          final String name = programs[index]['name'] as String;
                          final int programId = programs[index]['id'] as int;

                          return Container(
                            width: MediaQuery.sizeOf(context).width * 0.86,
                            height: 170,
                            margin: EdgeInsets.only(left: 4, right: 4),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image:
                                      AssetImage('${programs[index]['image']}'),
                                  fit: BoxFit.cover),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${name}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 28,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  TextButton(
                                      style: TextButton.styleFrom(
                                          fixedSize: Size(120, 40),
                                          backgroundColor: Colors.deepOrange,
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(16))),
                                      onPressed: () {
                                        context
                                            .read<WorkoutProvider>()
                                            .updatePlanId(programId);
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  PlanSessions(),
                                            ));
                                      },
                                      child: Text(
                                        "start",
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 19,
                                            fontWeight: FontWeight.bold),
                                      )),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox(
                      child: Text("empty"),
                    );
                  },
                ),
              ),
              Row(
                children: [
                  Text(
                    'Quick Start',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 6),
                padding: EdgeInsets.symmetric(horizontal: 10),
                height: 240,
                width: MediaQuery.sizeOf(context).width,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 110,
                    childAspectRatio: 1,
                  ),
                  itemCount: 4,
                  itemBuilder: (context, index) {
                    return QuickStartCard();
                  },
                ),
              ),
              Row(
                children: [
                  Text(
                    'Popular Workouts',
                    style: TextStyle(
                        color: Colors.grey[800],
                        fontSize: 20,
                        fontWeight: FontWeight.w700),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
                height: 100,
                child: BlocBuilder<PopularPlansBloc, PopularPlansState>(
                  builder: (context, state) {
                    if (state is PopularPlansLoading) {
                      final List<Map<String, Object>> programs =
                          state.popularPlans;
                      return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: programs.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: MediaQuery.sizeOf(context).width * 0.4,
                            height: 100,
                            margin: EdgeInsets.only(left: 4, right: 4),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image:
                                    AssetImage('${programs[index]['image']}'),
                                fit: BoxFit.cover,
                              ),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Padding(
                              padding: EdgeInsets.only(left: 20, bottom: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    '${programs[index]['name']}',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    }
                    return SizedBox(
                      child: Text("empty"),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    ));
  }
}
