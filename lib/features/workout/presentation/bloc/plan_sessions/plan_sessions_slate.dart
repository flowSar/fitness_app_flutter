abstract class PlanSessionsState {}

class PlanSessionsInitialState extends PlanSessionsState {}

class PlanSessionsLoading extends PlanSessionsState {}

class PlanSessionsLoaded extends PlanSessionsState {
  final List<Map<String, Object>> planSessions;
  final Map<String, Object> plan;
  PlanSessionsLoaded({required this.plan, required this.planSessions});
}

class PlanSessionsLoadingFailed extends PlanSessionsState {
  final String error;
  PlanSessionsLoadingFailed({required this.error});
}

class SessionComplete extends PlanSessionsState {}

class PlanProgress extends PlanSessionsState {
  final double progress;
  PlanProgress({required this.progress});
}
