abstract class WorkoutRemoteDatasource {
  Future<List<Map<String, dynamic>>> getPlanSessionExercises(
      String token, String planId);
}
