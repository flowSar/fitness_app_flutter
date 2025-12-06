import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:w_allfit/core/di/auth_injector.dart';
import 'package:w_allfit/core/router/routes.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_event.dart';
import 'package:w_allfit/features/settings/presentation/provider/settings_provider.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/advance_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/beginner_pans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/popular_plan_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/quick_start/quick_start_workout_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session_plan/workout_session_plan_bloc.dart';
import 'features/workout/presentation/provider/workout_provider.dart';

void main() {
  initializeDependencies();
  runApp(MultiProvider(
    providers: [
      BlocProvider(
        create: (_) => sl<UserPlansBloc>(),
      ),
      BlocProvider(
        create: (_) => PopularPlansBloc(),
      ),
      BlocProvider(
        create: (_) => BeginnerPlansBloc(),
      ),
      BlocProvider(
        create: (_) => AdvancePlansBloc(),
      ),
      BlocProvider(
        create: (_) => QuickStartWorkoutBloc(),
      ),
      BlocProvider(
        create: (_) => sl<WorkoutSessionPlanBloc>(),
      ),
      BlocProvider(
        create: (_) => sl<WorkoutSessionBloc>(),
      ),
      BlocProvider(
        create: (_) => sl<PlanSessionsBloc>(),
      ),
      ChangeNotifierProvider(
        create: (context) => WorkoutProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => SettingsProvider(),
      ),
      BlocProvider(create: (_) => sl<AuthBloc>())
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // final themeMode = context.watch<SettingsProvider>().themeMode;
  @override
  void initState() {
    context.read<AuthBloc>().add(CheckAuthState());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // final settings = Provider.of<SettingsProvider>(context);
    final settings = Provider.of<SettingsProvider>(context);
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: settings.themeMode,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      routerConfig: appRoutes,
    );
  }
}
