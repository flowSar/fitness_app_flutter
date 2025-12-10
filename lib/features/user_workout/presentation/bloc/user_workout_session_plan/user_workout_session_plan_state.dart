import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';

abstract class UserWorkoutSessionPlanState {}

class UserWorkoutSessionPlanInitialState extends UserWorkoutSessionPlanState {}

class UserSessionWorkoutPlanLoading extends UserWorkoutSessionPlanState {
  UserSessionWorkoutPlanLoading();
}

class UserSessionWorkoutPlanLoaded extends UserWorkoutSessionPlanState {
  final List<SessionExerciseModel> workoutPlan;
  UserSessionWorkoutPlanLoaded({required this.workoutPlan});
}

class UserSessionWorkoutPlanLoadingFailed extends UserWorkoutSessionPlanState {
  final String error;
  UserSessionWorkoutPlanLoadingFailed({required this.error});
}
