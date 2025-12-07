import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/data/models/user_plan_model.dart';

class PlanModel extends PlanEntity {
  PlanModel({
    required super.id,
    required super.name,
    required super.description,
    required super.level,
    required super.image,
    required super.video,
    required super.duration,
    required super.sessionsNumber,
  });

  factory PlanModel.fromEntity(PlanEntity plan) {
    return PlanModel(
      id: plan.id,
      name: plan.name,
      description: plan.description,
      level: plan.level,
      image: plan.image,
      video: plan.video,
      duration: plan.duration,
      sessionsNumber: plan.sessionsNumber,
    );
  }
  factory PlanModel.fromJson(Map<String, dynamic> json) {
    return PlanModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      level: json['level'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      duration: json['duration'] ?? 0,
      sessionsNumber: json['sessions_number'] ?? 1,
    );
  }

  factory PlanModel.fromUserPlanModel(UserPlanModel userPlanModel) {
    return PlanModel(
      id: userPlanModel.id,
      name: userPlanModel.name,
      description: userPlanModel.description,
      level: userPlanModel.level,
      image: userPlanModel.image,
      video: userPlanModel.video,
      duration: userPlanModel.duration,
      sessionsNumber: userPlanModel.sessionsNumber,
    );
  }
}
