import 'package:w_allfit/features/explore/data/models/plan_model.dart';

abstract class WorkoutPlansState {}

class WorkoutPlansInitialState extends WorkoutPlansState {}

class WorkoutPlansLoading extends WorkoutPlansState {}

class WorkoutPlansLoadingfailed extends WorkoutPlansState {
  final String error;
  WorkoutPlansLoadingfailed({required this.error});
}

class WorkoutPlansLoaded extends WorkoutPlansState {
  final List<PlanModel> workoutPlans;

  WorkoutPlansLoaded({required this.workoutPlans});
}
