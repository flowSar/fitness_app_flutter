import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';

abstract class SessionWorkoutPlanState {}

class WorkoutSessionPlanInitialState extends SessionWorkoutPlanState {}

class SessionWorkoutPlanLoading extends SessionWorkoutPlanState {
  SessionWorkoutPlanLoading();
}

class SessionWorkoutPlanLoaded extends SessionWorkoutPlanState {
  final List<SessionExerciseModel> workoutPlan;
  SessionWorkoutPlanLoaded({required this.workoutPlan});
}

class SessionWorkoutPlanLoadingFailed extends SessionWorkoutPlanState {
  final String error;
  SessionWorkoutPlanLoadingFailed({required this.error});
}
