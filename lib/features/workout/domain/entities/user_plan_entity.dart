import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';

class UserPlan {
  final String id;
  final Plan plan;
  final double progress;
  final bool complete;

  UserPlan(
      {required this.id,
      required this.plan,
      required this.progress,
      required this.complete});
}
