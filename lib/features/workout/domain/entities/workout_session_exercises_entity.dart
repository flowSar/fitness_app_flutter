class WorkoutSessionExercises {
  final int id;
  final String sessionId;
  final String exerciseId;
  final bool complete;
  final int duration;
  final int sets;
  final int reps;

  WorkoutSessionExercises({
    required this.id,
    required this.sessionId,
    required this.complete,
    required this.sets,
    required this.reps,
    required this.duration,
    required this.exerciseId,
  });
}
