import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class GetPlans {
  final WorkoutRepository workoutRepository;
  GetPlans({required this.workoutRepository});

  Future<List<Plan>> call() async {
    return workoutRepository.getPlans();
  }
}
