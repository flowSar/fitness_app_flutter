import 'package:w_allfit/features/workout/data/models/session_model.dart';

abstract class UserPlanSessionsState {}

class UserPlanSessionsInitialState extends UserPlanSessionsState {}

class UserPlanSessionsLoading extends UserPlanSessionsState {}

class UserPlanSessionsLoaded extends UserPlanSessionsState {
  final List<SessionModel> planSessions;

  UserPlanSessionsLoaded({required this.planSessions});
}

class UserPlanSessionsLoadingFailed extends UserPlanSessionsState {
  final String error;
  UserPlanSessionsLoadingFailed({required this.error});
}

class UserSessionComplete extends UserPlanSessionsState {}

class UserPlanProgress extends UserPlanSessionsState {
  final double progress;
  UserPlanProgress({required this.progress});
}
