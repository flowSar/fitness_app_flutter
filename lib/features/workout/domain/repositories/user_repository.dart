import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<void> insertUser(User user);

  Future<void> insertUserPlan(String userId, String planId);

  Future<List<Plan>> getUserPlans(String userId);

  Future<void> insertUserPlanSessions(String userId, String planId);

  Future<void> insertUserPlanSessionWorkoutExercises(
      String userId, String planId, String sessionId, List<Exercise> exercises);

  Future<void> getUserPlanSessions(String userId, String planId);

  Future<void> getUserPlanSessionWorkoutExercises(
      String userId, String planId, String sessionId);
}
