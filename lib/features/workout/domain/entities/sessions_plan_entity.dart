import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';

class PlanSessions {
  final Plan plan;
  final List<Session> sessions;
  PlanSessions({required this.plan, required this.sessions});
}
