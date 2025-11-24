import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/user_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  @override
  Future<void> getUserPlanSessionWorkoutExercises(
      String userId, String planId, String sessionId) {
    // TODO: implement getUserPlanSessionWorkoutExercises
    throw UnimplementedError();
  }

  @override
  Future<void> getUserPlanSessions(String userId, String planId) {
    // TODO: implement getUserPlanSessions
    throw UnimplementedError();
  }

  @override
  Future<List<Plan>> getUserPlans(String userId) {
    // TODO: implement getUserPlans
    throw UnimplementedError();
  }

  @override
  Future<void> insertUser(User user) {
    // TODO: implement insertUser
    throw UnimplementedError();
  }

  @override
  Future<void> insertUserPlan(String userId, String planId) {
    // TODO: implement insertUserPlan
    throw UnimplementedError();
  }

  @override
  Future<void> insertUserPlanSessionWorkoutExercises(String userId,
      String planId, String sessionId, List<Exercise> exercises) {
    // TODO: implement insertUserPlanSessionWorkoutExercises
    throw UnimplementedError();
  }

  @override
  Future<void> insertUserPlanSessions(String userId, String planId) {
    // TODO: implement insertUserPlanSessions
    throw UnimplementedError();
  }
}
