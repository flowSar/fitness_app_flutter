import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:w_allfit/b_navigation_bar.dart';
import 'package:w_allfit/core/constants/constants.dart';
import 'package:w_allfit/features/explore/presentation/screens/workout_plans_list_screen.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_event.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_state.dart';
import 'package:w_allfit/features/auth/presentation/screens/sign_in_screen.dart';
import 'package:w_allfit/features/auth/presentation/screens/sign_up_screen.dart';
import 'package:w_allfit/features/nutrition/presentation/view_more_nutrition.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_complete_screen.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_exercise_screen.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_plan_session_screen.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_plan_sessions.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_prepare_screen.dart';
import 'package:w_allfit/features/workout/presentation/screens/workout_rest_screen.dart';
import 'package:w_allfit/test_page.dart';
import 'package:w_allfit/welcome_screen.dart';

final GoRouter appRoutes = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => WelcomeScreen(),
      // builder: (context, state) => FutureBuilder<bool>(
      //   future: hasSeenWelcomeScreen(), // Check if welcome screen is needed
      //   builder: (context, snapshot) {
      //     if (snapshot.connectionState == ConnectionState.waiting) {
      //       return Center(child: CircularProgressIndicator());
      //     }
      //     if (snapshot.hasData && snapshot.data == false) {
      //       return WelcomeScreen(); // Show welcome screen if not seen yet
      //     } else {
      //       return BNavigationBar(); // Otherwise, go to the main home screen
      //     }
      //   },
      // ),

      // builder: (context, state) => WelcomeScreen(),
      routes: [
        GoRoute(
          path: "/workoutScreen",
          builder: (context, state) {
            final authState = context.watch<AuthBloc>().state;
            if (authState is LoginSucess) {
              return BNavigationBar();
            }

            if (authState is Authenticated && authState.isAuthenticated) {
              return BNavigationBar();
            }
            return SignInScreen();
          },
        ),
        GoRoute(
          path: '/workoutPlanSessions',
          builder: (context, state) => WorkoutPlanSessions(),
        ),
        GoRoute(
          path: '/workoutPlanSession',
          builder: (context, state) => WorkoutPlanSessionScreen(),
        ),
        GoRoute(
          path: '/workoutExercise',
          builder: (context, state) => WorkoutExerciseScreen(),
        ),
        GoRoute(
          path: '/workoutRest',
          builder: (context, state) => WorkoutRestScreen(),
        ),
        GoRoute(
          path: '/workoutComplete',
          builder: (context, state) => WorkoutCompleteScreen(),
        ),
        GoRoute(
          path: "/workoutPrepare",
          builder: (context, state) => WorkoutPrepareScreen(),
        ),
        GoRoute(
          path: '/viewMoreNutrition',
          builder: (context, state) {
            final category = state.extra as String;

            return ViewMoreNutrition(category: category);
          },
        ),
        GoRoute(
          path: '/signIn',
          builder: (context, state) => SignInScreen(),
        ),
        GoRoute(
          path: '/signUp',
          builder: (context, state) => SignUpScreen(),
        ),
        GoRoute(
          path: '/testPage',
          builder: (context, state) => TestPage(),
        ),
        GoRoute(
          path: 'workoutPlanslist',
          builder: (context, state) {
            final ScreenType? screenType = state.extra as ScreenType;
            if (screenType == null) {
              return WorkoutPlansListScreen();
            }
            return WorkoutPlansListScreen(
              screenType: screenType,
            );
          },
        )
      ],
    ),
  ],
);
