import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';

abstract class UserPlanRepository {
  Future<void> insertUserPlan(String userId, String planId);

  Future<Result<List<PlanEntity>>> getUserPlans(String token);

  Future<Result<List<SessionEntity>>> getUserPlanSessions(
      String token, String planId);

  Future<void> getUserPlanSessionWorkoutExercises(
      String userId, String planId, String sessionId);
}
