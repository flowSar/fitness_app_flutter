import 'package:w_allfit/core/data/models/exercise_model.dart';

abstract class WorkoutSessionState {}

class WorkoutSessionInitialState extends WorkoutSessionState {}

class WorkoutExerciseInProgressLoading extends WorkoutSessionState {}

class WorkoutExerciseInProgress extends WorkoutSessionState {
  final ExerciseModel exercise;
  final List<ExerciseModel> exercises;
  final int index;
  WorkoutExerciseInProgress({
    required this.exercise,
    required this.exercises,
    required this.index,
  });
}

class WorkoutComplete extends WorkoutSessionState {}

class WorkoutSessionLoading extends WorkoutSessionState {}

class WorkoutSessionLoaded extends WorkoutSessionState {
  final List<ExerciseModel> exercises;
  WorkoutSessionLoaded({required this.exercises});
}

class WorkoutSessionLoadingFailed extends WorkoutSessionState {
  final String error;
  WorkoutSessionLoadingFailed({required this.error});
}
