import 'package:w_allfit/features/workout/data/models/plan_model.dart';

abstract class UserPlansState {
  List<PlanModel> get userPlans => [];
}

class UserPlansInitialState extends UserPlansState {}

class UserPlansLoading extends UserPlansState {}

class UserPlanProgressLoaded extends UserPlansState {
  @override
  final List<PlanModel> userPlans;
  final int progress;
  UserPlanProgressLoaded({required this.userPlans, required this.progress});
}

class UserPlansLoaded extends UserPlansState {
  final List<PlanModel> userPlans;

  UserPlansLoaded({required this.userPlans});
}

class UserPlansLoadingFailed extends UserPlansState {
  final String error;
  UserPlansLoadingFailed({required this.error});
}
