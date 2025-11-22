abstract class WorkoutSessionState {}

class WorkoutSessionInitialState extends WorkoutSessionState {}

class WorkoutExerciseInProgress extends WorkoutSessionState {
  final Map<String, Object> exercise;
  final Map<String, Object> sessionExercises;
  final int index;
  final int sessionId;
  WorkoutExerciseInProgress(
      {required this.exercise,
      required this.sessionExercises,
      required this.index,
      required this.sessionId});
}

class WorkoutComplete extends WorkoutSessionState {}

class WorkoutSessionProgress extends WorkoutSessionState {
  final double progress;
  WorkoutSessionProgress({required this.progress});
}
