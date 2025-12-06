import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';

abstract class UserRemoteDataSource {
  Future<List<Map<String, dynamic>>> getUserWorkoutPlans(String token);
  Future<Map<String, dynamic>> createUserWorkoutPlans(
      String token, String planId);

  Future<List<Map<String, dynamic>>> getuserPlanSessions(
      String token, String planId);
}
