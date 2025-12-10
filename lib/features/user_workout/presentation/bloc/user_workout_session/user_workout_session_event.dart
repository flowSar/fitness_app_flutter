import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';

abstract class UserWorkoutSessionEvent {}

class StartUserWorkout extends UserWorkoutSessionEvent {
  final List<SessionExerciseModel> workoutPlan;
  final int index;

  StartUserWorkout({
    required this.index,
    required this.workoutPlan,
  });
}

class NextUserWorkoutExercise extends UserWorkoutSessionEvent {
  final PlanModel plan;
  NextUserWorkoutExercise({required this.plan});
}

class UpdateUserWorkoutSessionProgress extends UserWorkoutSessionEvent {
  final int sessionId;
  UpdateUserWorkoutSessionProgress({required this.sessionId});
}
