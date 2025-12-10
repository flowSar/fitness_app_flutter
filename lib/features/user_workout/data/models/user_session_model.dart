import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';

class UserSessionModel extends SessionEntity {
  UserSessionModel({
    required super.id,
    required super.name,
    required super.complete,
    required super.progress,
    required super.duration,
    required super.planId,
  });

  factory UserSessionModel.fromJson(Map<String, dynamic> json) {
    return UserSessionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      complete: json['complete'] ?? false,
      progress: (json['progress'] as num).toDouble(),
      duration: json['duration'] ?? 0,
      planId: json['planId'] ?? '',
    );
  }

  factory UserSessionModel.fromEntity(SessionEntity session) {
    return UserSessionModel(
        id: session.id,
        name: session.name,
        complete: session.complete,
        progress: session.progress,
        duration: session.duration,
        planId: session.planId);
  }
}
