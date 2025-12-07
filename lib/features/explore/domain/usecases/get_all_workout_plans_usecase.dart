import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/explore/domain/repositories/workout_plans_repository.dart';

class GetAllWorkoutPlansUsecase {
  final WorkoutPlansRepository workoutPlansRepository;

  GetAllWorkoutPlansUsecase({required this.workoutPlansRepository});

  Future<Result<List<PlanEntity>>> call() {
    return workoutPlansRepository.getAllWorkoutPlans();
  }
}
