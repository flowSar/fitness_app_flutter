import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';

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
    required super.type,
  });

  // copyWith function to create a new instance with some properties changed
  UserPlanModel copyWith({
    String? id,
    String? name,
    String? description,
    String? level,
    String? image,
    String? video,
    int? duration,
    int? sessionsNumber,
    bool? complete,
    double? progress,
    String? type,
  }) {
    return UserPlanModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      level: level ?? this.level,
      image: image ?? this.image,
      video: video ?? this.video,
      duration: duration ?? this.duration,
      sessionsNumber: sessionsNumber ?? this.sessionsNumber,
      complete: complete ?? this.complete,
      progress: progress ?? this.progress,
      type: type ?? this.type,
    );
  }

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
      type: plan.type,
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
      sessionsNumber: json['sessionsNumber'] ?? 1,
      complete: json['complete'] ?? false,
      progress: (json['progress'] as num).toDouble(),
      type: json['type'] ?? '',
    );
  }
  UserPlanModel toUserPlanModel(PlanModel planModel) {
    return UserPlanModel(
        id: planModel.id,
        name: planModel.name,
        description: planModel.description,
        level: planModel.level,
        image: planModel.image,
        video: planModel.video,
        duration: planModel.duration,
        sessionsNumber: planModel.sessionsNumber,
        complete: planModel.complete,
        progress: planModel.progress,
        type: planModel.type);
  }

  factory UserPlanModel.fromPlanModel(PlanModel planModel) {
    return UserPlanModel(
        id: planModel.id,
        name: planModel.name,
        description: planModel.description,
        level: planModel.level,
        image: planModel.image,
        video: planModel.video,
        duration: planModel.duration,
        sessionsNumber: planModel.sessionsNumber,
        complete: planModel.complete,
        progress: planModel.progress,
        type: planModel.type);
  }
}
