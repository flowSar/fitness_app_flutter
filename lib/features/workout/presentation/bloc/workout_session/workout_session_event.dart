import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';

abstract class WorkoutSessionEvent {}

class StartWorkout extends WorkoutSessionEvent {
  final List<SessionExerciseModel> workoutPlan;
  final int index;
  StartWorkout({required this.index, required this.workoutPlan});
}

class NextWorkoutExercise extends WorkoutSessionEvent {
  NextWorkoutExercise();
}

class UpdateWorkoutSessionProgress extends WorkoutSessionEvent {
  final int sessionId;
  UpdateWorkoutSessionProgress({required this.sessionId});
}
