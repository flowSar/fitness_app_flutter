import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/user_plan_entity.dart';

class UserPlanModel extends UserPlan {
  UserPlanModel(
      {required super.id,
      required super.plan,
      required super.progress,
      required super.complete});
}
