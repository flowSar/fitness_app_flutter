import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';

abstract class WorkoutSessionState {}

class WorkoutSessionInitialState extends WorkoutSessionState {}

class WorkoutExerciseInProgressLoading extends WorkoutSessionState {}

class WorkoutExerciseInProgress extends WorkoutSessionState {
  final SessionExerciseModel exercise;
  final List<SessionExerciseModel> workoutPlan;
  final int index;
  WorkoutExerciseInProgress(
      {required this.exercise, required this.index, required this.workoutPlan});
}

class WorkoutComplete extends WorkoutSessionState {}

class WorkoutSessionLoading extends WorkoutSessionState {}

class WorkoutSessionLoaded extends WorkoutSessionState {
  final double progress;
  WorkoutSessionLoaded({required this.progress});
}
