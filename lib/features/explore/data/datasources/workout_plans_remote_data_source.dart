abstract class WorkoutPlansRemoteDataSource {
  Future<List<Map<String, dynamic>>> getAllWorkoutPlans(String query);
}
