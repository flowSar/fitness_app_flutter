import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/workout/data/models/exercise_model.dart';
import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';

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

// class WorkoutSessionLoaded extends WorkoutSessionState {
//   final double progress;
//   WorkoutSessionLoaded({required this.progress});
// }

// class WorkoutSessionLoading extends WorkoutSessionState {
//   WorkoutSessionLoading();
// }

class WorkoutSessionLoaded extends WorkoutSessionState {
  final List<ExerciseModel> exercises;
  WorkoutSessionLoaded({required this.exercises});
}

class WorkoutSessionLoadingFailed extends WorkoutSessionState {
  final String error;
  WorkoutSessionLoadingFailed({required this.error});
}
