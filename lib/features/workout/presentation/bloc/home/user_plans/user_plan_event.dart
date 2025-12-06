abstract class UserPlansEvent {}

class LoadUserPlans extends UserPlansEvent {}

class LoadUserPlanProgress extends UserPlansEvent {
  final int planId;
  LoadUserPlanProgress({required this.planId});
}
