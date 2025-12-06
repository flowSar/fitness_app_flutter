import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';

class SessionModel extends SessionEntity {
  SessionModel({
    required super.id,
    required super.name,
    required super.complete,
    required super.progress,
    required super.duration,
    required super.planId,
  });

  factory SessionModel.fromJson(Map<String, dynamic> json) {
    return SessionModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      complete: json['complete'] ?? false,
      progress: (json['progress'] as num).toDouble(),
      duration: json['duration'] ?? 0,
      planId: json['planId'] ?? '',
    );
  }

  factory SessionModel.fromEntity(SessionEntity session) {
    return SessionModel(
        id: session.id,
        name: session.name,
        complete: session.complete,
        progress: session.progress,
        duration: session.duration,
        planId: session.planId);
  }
}
