abstract class UserRemoteDataSource {
  Future<List<Map<String, dynamic>>> getUserWorkoutPlans(String token);
  Future<Map<String, dynamic>> addUserPlan(String token, String planId);

  Future<List<Map<String, dynamic>>> getuserPlanSessions(
      String token, String planId);

  Future<List<Map<String, dynamic>>> getUserPlanSessionExercises(
      String token, String sessionId);

  Future<Map<String, dynamic>> markUserPlansessionExerciseComplete(
      String token, String sessionExerciseId);

  Future<Map<String, dynamic>> markUserPlansessionComplete(
      String token, String sessionId);
}
