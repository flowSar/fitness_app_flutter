import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:w_allfit/core/di/auth_injector.dart';
import 'package:w_allfit/core/router/routes.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_event.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_bloc.dart';
import 'package:w_allfit/features/settings/presentation/provider/settings_provider.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/exercises/exercises_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/plan_sessions/user_plan_sessions_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plans_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session_plan/user_workout_session_plan_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/provider/user_workout_provider.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/advance_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/beginner_pans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/popular_plan_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/quick_start/quick_start_workout_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';
import 'package:w_allfit/features/workout/presentation/provider/workout_provider.dart';

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
        create: (_) => sl<UserWorkoutSessionPlanBloc>(),
      ),
      BlocProvider(
        create: (_) => sl<UserWorkoutSessionBloc>(),
      ),
      BlocProvider(
        create: (_) => sl<UserPlanSessionsBloc>(),
      ),
      BlocProvider(create: (_) => sl<ExercisesBloc>()),
      BlocProvider(create: (_) => sl<WorkoutPlansBloc>()),
      BlocProvider(create: (_) => sl<WorkoutSessionBloc>()),
      ChangeNotifierProvider(
        create: (context) => UserWorkoutProvider(),
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
  @override
  void initState() {
    context.read<AuthBloc>().add(CheckAuthState());
    setUserLogDates();
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
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        Locale('en', 'US'), // English
        Locale('ar', 'AE'), // Arabic
      ],
      locale: Locale('en', 'US'),
    );
  }
}
