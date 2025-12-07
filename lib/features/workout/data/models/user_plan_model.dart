import 'package:w_allfit/core/constants/plansType.dart';
import 'package:w_allfit/core/domain/entities/plan_entity.dart';

class UserPlanModel extends PlanEntity {
  UserPlanModel({
    required super.id,
    required super.name,
    required super.description,
    required super.level,
    required super.image,
    required super.video,
    required super.duration,
    required super.sessionsNumber,
    required super.complete,
    required super.progress,
  });

  factory UserPlanModel.fromEntity(PlanEntity plan) {
    return UserPlanModel(
      id: plan.id,
      name: plan.name,
      description: plan.description,
      level: plan.level,
      image: plan.image,
      video: plan.video,
      duration: plan.duration,
      sessionsNumber: plan.sessionsNumber,
      complete: plan.complete,
      progress: plan.progress,
    );
  }
  factory UserPlanModel.fromJson(Map<String, dynamic> json) {
    return UserPlanModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      level: json['level'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      duration: json['duration'] ?? 0,
      sessionsNumber: json['sessions_number'] ?? 1,
      complete: json['complete'] ?? false,
      progress: (json['progress'] as num).toDouble(),
    );
  }
}
