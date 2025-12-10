abstract class UserPlanSessionsEvent {}

class LoadUserPlanSessions extends UserPlanSessionsEvent {
  final String planId;
  LoadUserPlanSessions({required this.planId});
}

class MarkUserSessionComplete extends UserPlanSessionsEvent {
  final int sessionId;
  MarkUserSessionComplete({required this.sessionId});
}

class LoadUserPlanProgress extends UserPlanSessionsEvent {}
