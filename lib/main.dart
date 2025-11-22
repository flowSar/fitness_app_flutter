import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:w_allfit/b_navigation_bar.dart';
import 'package:w_allfit/core/router/routes.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/popular_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/quick_start/quick_start_workout_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/sessions/sessions_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session_plan/session_workout_plan_bloc.dart';

import 'features/workout/presentation/provider/workout_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => UserPlansBloc(),
          ),
          BlocProvider(
            create: (_) => PlansBloc(),
          ),
          BlocProvider(
            create: (_) => QuickStartWorkoutBloc(),
          ),
          BlocProvider(
            create: (_) => SessionWorkoutPlanBloc(),
          ),
          BlocProvider(
            create: (_) => WorkoutSessionBloc(),
          ),
          BlocProvider(
            create: (_) => PlanSessionsBloc(),
          ),
          ChangeNotifierProvider(
            create: (context) => WorkoutProvider(),
          ),
        ],
        child: MaterialApp.router(
          routerConfig: appRoutes,
        ));
  }
}
