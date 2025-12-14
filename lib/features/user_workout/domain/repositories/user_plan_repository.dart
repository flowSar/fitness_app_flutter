import 'package:w_allfit/core/domain/entities/exercise_entity.dart';
import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/session_exercise_entity.dart';

abstract class UserPlanRepository {
  Future<Result<PlanEntity>> adduserPlan(String token, String planId);

  Future<Result<PlanEntity>> createUserPlan(String token, String planName,
      bool visibility, List<ExerciseEntity> exercises);

  Future<Result<List<PlanEntity>>> getUserPlans(String token);

  Future<Result<List<SessionEntity>>> getUserPlanSessions(
      String token, String planId);

  Future<Result<List<SessionExerciseEntity>>> getUserPlanSessionExercises(
      String token, String sessionId);

  Future<Result<SessionExerciseEntity>> markUserPlansessionExerciseComplete(
      String token, String sessionExerciseId);
  Future<Result<SessionEntity>> markUserPlansessionComplete(
      String token, String sessionId);

  Future<Result<List<ExerciseEntity>>> getAllExercises(String token);
}
