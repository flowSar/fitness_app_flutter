import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class InsertPlan {
  final WorkoutRepository workoutRepository;
  InsertPlan({required this.workoutRepository});

  Future<void> call(Plan plan) {
    return workoutRepository.insertPlan(plan);
  }
}
