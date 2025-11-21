import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:w_allfit/b_navigation_bar.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/popular_plans/popular_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/sessions/sessions_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_bloc.dart';

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
            create: (_) => WorkoutBloc(),
          ),
          BlocProvider(
            create: (_) => UserPlansBloc(),
          ),
          BlocProvider(
            create: (_) => PopularPlansBloc(),
          ),
          BlocProvider(
            create: (_) => PlanSessionsBloc(),
          ),
          ChangeNotifierProvider(
            create: (context) => WorkoutProvider(),
          ),
        ],
        child: MaterialApp(
          home: BNavigationBar(),
        ));
  }
}
