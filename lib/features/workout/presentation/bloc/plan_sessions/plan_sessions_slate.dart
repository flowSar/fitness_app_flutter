import 'package:w_allfit/features/workout/data/models/session_model.dart';

abstract class PlanSessionsState {}

class PlanSessionsInitialState extends PlanSessionsState {}

class PlanSessionsLoading extends PlanSessionsState {}

class PlanSessionsLoaded extends PlanSessionsState {
  final List<SessionModel> planSessions;

  PlanSessionsLoaded({required this.planSessions});
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
