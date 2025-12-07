import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class GetPlans {
  final WorkoutRepository workoutRepository;
  GetPlans({required this.workoutRepository});

  Future<List<PlanEntity>> call() async {
    return workoutRepository.getPlans();
  }
}
