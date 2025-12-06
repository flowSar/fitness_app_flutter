abstract class SessionWorkoutPlanEvent {}

class LoadSessionWorkoutPlan extends SessionWorkoutPlanEvent {
  final String sessionId;
  LoadSessionWorkoutPlan({required this.sessionId});
}
