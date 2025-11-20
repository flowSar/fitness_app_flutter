abstract class WorkoutEvent {}

class StartWorkoutEvent extends WorkoutEvent {
  final planId;
  final int sessionId;
  StartWorkoutEvent({required this.planId, required this.sessionId});
}

class GetWorkoutPlanEvent extends WorkoutEvent {
  final int planId;
  GetWorkoutPlanEvent({required this.planId});
}

class NextExerciseEvent extends WorkoutEvent {
  NextExerciseEvent();
}

class MarkExerciseCompleteEvent extends WorkoutEvent {
  MarkExerciseCompleteEvent();
}

class MarkWorkouSessionCompleteEvent extends WorkoutEvent {
  final int sessionId;
  MarkWorkouSessionCompleteEvent({required this.sessionId});
}
