import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/core/result.dart';

abstract class WorkoutPlansRepository {
  Future<Result<List<PlanEntity>>> getAllWorkoutPlans(String query);
}
