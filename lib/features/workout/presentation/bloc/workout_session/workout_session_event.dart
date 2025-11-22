abstract class WorkoutSessionEvent {}

class StartWorkout extends WorkoutSessionEvent {
  final int sessionId;
  final int index;
  StartWorkout({required this.index, required this.sessionId});
}

class NextWorkoutExercise extends WorkoutSessionEvent {
  NextWorkoutExercise();
}

class UpdateWorkoutSessionProgress extends WorkoutSessionEvent {
  final int sessionId;
  UpdateWorkoutSessionProgress({required this.sessionId});
}
