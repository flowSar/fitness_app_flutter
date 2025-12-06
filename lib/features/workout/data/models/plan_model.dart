import 'package:w_allfit/core/constants/plansType.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';

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
    required super.complete,
    required super.progress,
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
      complete: plan.complete,
      progress: plan.progress,
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
      complete: json['complete'] ?? false,
      progress: (json['progress'] as num).toDouble(),
    );
  }
}
