import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';

class SessionModel extends Session {
  SessionModel(
      {required super.id,
      required super.dayNumber,
      required super.complete,
      required super.progress,
      required super.duration,
      required super.planId});
}
