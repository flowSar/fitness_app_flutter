abstract class WorkoutState {}

class InitialWorkoutStat extends WorkoutState {}

class WorkoutInProgress extends WorkoutState {
  final Map<String, Object> currentExercise;
  final int index;
  final int sessionId;
  WorkoutInProgress(
      {required this.currentExercise,
      required this.index,
      required this.sessionId});
}

class ProgramsLoading extends WorkoutState {
  final List<Map<String, Object>> programs;
  ProgramsLoading({required this.programs});
}

class SelectedWorkoutPlan extends WorkoutState {
  final List<Map<String, Object>> currentWorkoutPlan;
  SelectedWorkoutPlan({required this.currentWorkoutPlan});
}

class WorkoutSessionCompleted extends WorkoutState {}

class ExercisesUpdatedSuccess extends WorkoutState {}

class ExercisesUpdatedFailed extends WorkoutState {}

class WorkoutComplete extends WorkoutState {}

class SessionComplete extends WorkoutState {}
