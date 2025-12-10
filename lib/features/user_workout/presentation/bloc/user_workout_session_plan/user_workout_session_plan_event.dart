abstract class UserSessionWorkoutPlanEvent {}

class LoadUserSessionWorkoutPlan extends UserSessionWorkoutPlanEvent {
  final String sessionId;
  LoadUserSessionWorkoutPlan({required this.sessionId});
}
