abstract class PlanSessionsEvent {}

class LoadPlanSessions extends PlanSessionsEvent {
  final int PlanId;
  LoadPlanSessions({required this.PlanId});
}

class MarkSessionComplete extends PlanSessionsEvent {
  final int sessionId;
  MarkSessionComplete({required this.sessionId});
}

class LoadPlanProgress extends PlanSessionsEvent {}
