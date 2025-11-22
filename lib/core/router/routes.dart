import 'package:go_router/go_router.dart';
import 'package:w_allfit/b_navigation_bar.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_exercise_screen.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_plan_sessions.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_rest_screen.dart';

final GoRouter appRoutes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => BNavigationBar(),
      routes: [
        GoRoute(
          path: '/workoutPlanSessions',
          builder: (context, state) => WorkoutPlanSessions(),
        ),
        GoRoute(
          path: '/workoutExercise',
          builder: (context, state) => WorkoutExerciseScreen(),
        ),
        GoRoute(
          path: '/workoutRest',
          builder: (context, state) => WorkoutRestScreen(),
        ),
      ],
    ),
  ],
);
