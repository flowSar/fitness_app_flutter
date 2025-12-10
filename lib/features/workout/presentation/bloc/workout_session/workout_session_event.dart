import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/workout/data/models/exercise_model.dart';
import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';

abstract class WorkoutSessionEvent {}

class StartWorkout extends WorkoutSessionEvent {
  final List<ExerciseModel> exercises;
  final int index;

  StartWorkout({
    required this.index,
    required this.exercises,
  });
}

class NextWorkoutExercise extends WorkoutSessionEvent {
  NextWorkoutExercise();
}

class UpdateWorkoutSessionProgress extends WorkoutSessionEvent {
  final int sessionId;
  UpdateWorkoutSessionProgress({required this.sessionId});
}

class LoadWorkoutSession extends WorkoutSessionEvent {
  final String planId;
  LoadWorkoutSession({required this.planId});
}
