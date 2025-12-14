import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/explore/data/datasources/workout_plans_remote_data_source.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/explore/domain/repositories/workout_plans_repository.dart';

class WorkoutPlansRepositoryImpl extends WorkoutPlansRepository {
  final WorkoutPlansRemoteDataSource workoutPlansRemoteDataSource;

  WorkoutPlansRepositoryImpl({required this.workoutPlansRemoteDataSource});

  @override
  Future<Result<List<PlanEntity>>> getAllWorkoutPlans(String query) async {
    try {
      final data = await workoutPlansRemoteDataSource.getAllWorkoutPlans(query);
      final List<PlanModel> workoutPlans =
          data.map((jsonPlan) => PlanModel.fromJson(jsonPlan)).toList();
      print('workoutPlans not user: $workoutPlans');
      return Result.success(workoutPlans);
    } catch (e) {
      print('loading workout plans failed: ${e.toString()}');
      return Result.failure(e.toString());
    }
  }
}
