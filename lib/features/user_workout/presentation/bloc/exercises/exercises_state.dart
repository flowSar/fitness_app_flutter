import 'package:w_allfit/core/data/models/exercise_model.dart';

abstract class ExercisesState {}

class ExercisesInitiaState extends ExercisesState {}

class ExercisesLaoding extends ExercisesState {}

class ExercisesLoaded extends ExercisesState {
  final List<ExerciseModel> exercises;

  ExercisesLoaded({required this.exercises});
}

class ExercisesLaodingFailed extends ExercisesState {
  final String error;

  ExercisesLaodingFailed({required this.error});
}
