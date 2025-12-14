import 'package:w_allfit/core/data/models/exercise_model.dart';

abstract class UserPlansEvent {}

class LoadUserPlans extends UserPlansEvent {}

class LoadUserPlanProgress extends UserPlansEvent {
  final int planId;
  LoadUserPlanProgress({required this.planId});
}

class AddUserPlanEvent extends UserPlansEvent {
  final String planId;
  AddUserPlanEvent({required this.planId});
}

class CreateUserPlan extends UserPlansEvent {
  final String planName;
  final bool visibility;
  final List<ExerciseModel> exercises;
  CreateUserPlan({
    required this.planName,
    required this.visibility,
    required this.exercises,
  });
}
