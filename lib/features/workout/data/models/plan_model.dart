import 'package:w_allfit/core/constants/plansType.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';

class PlanModel extends Plan {
  PlanModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.level,
      required super.image,
      required super.video,
      required super.duration,
      required super.sessionsNumber,
      required super.type});
}
