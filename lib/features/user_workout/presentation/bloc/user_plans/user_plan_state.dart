import 'package:w_allfit/features/user_workout/data/models/user_plan_model.dart';

abstract class UserPlansState {
  List<UserPlanModel> get userPlans => [];
}

class UserPlansInitialState extends UserPlansState {}

class UserPlansLoading extends UserPlansState {}

class UserPlanProgressLoaded extends UserPlansState {
  @override
  final List<UserPlanModel> userPlans;
  final int progress;
  UserPlanProgressLoaded({required this.userPlans, required this.progress});
}

class UserPlansLoaded extends UserPlansState {
  @override
  final List<UserPlanModel> userPlans;

  UserPlansLoaded({required this.userPlans});
}

class UserPlansLoadingFailed extends UserPlansState {
  final String error;
  UserPlansLoadingFailed({required this.error});
}

class UserPlanAdding extends UserPlansState {}

class UserPlanAddedSuccess extends UserPlansState {}

class UserPlanAddedFailure extends UserPlansState {
  final String error;
  UserPlanAddedFailure(this.error);
}

class CreateUserPlanLoading extends UserPlansState {}

class CreateUserPlanSuccess extends UserPlansState {}

class CreateUserPlanFailed extends UserPlansState {
  final String error;
  CreateUserPlanFailed(this.error);
}
