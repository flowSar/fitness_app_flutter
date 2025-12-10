import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';

abstract class UserWorkoutSessionState {}

class UserWorkoutSessionInitialState extends UserWorkoutSessionState {}

class UserWorkoutExerciseInProgressLoading extends UserWorkoutSessionState {}

class UserWorkoutExerciseInProgress extends UserWorkoutSessionState {
  final SessionExerciseModel exercise;
  final List<SessionExerciseModel> workoutPlan;
  final int index;
  UserWorkoutExerciseInProgress({
    required this.exercise,
    required this.index,
    required this.workoutPlan,
  });
}

class UserWorkoutComplete extends UserWorkoutSessionState {}

class UserWorkoutSessionLoading extends UserWorkoutSessionState {}

class UserWorkoutSessionLoaded extends UserWorkoutSessionState {
  final double progress;
  UserWorkoutSessionLoaded({required this.progress});
}
