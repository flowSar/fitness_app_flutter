abstract class PlanSessionsEvent {}

class LoadPlanSessions extends PlanSessionsEvent {
  final String planId;
  LoadPlanSessions({required this.planId});
}

class MarkSessionComplete extends PlanSessionsEvent {
  final int sessionId;
  MarkSessionComplete({required this.sessionId});
}

class LoadPlanProgress extends PlanSessionsEvent {}
