import 'package:w_allfit/features/workout/domain/entities/sessions_plan_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class GetPlanSessions {
  final WorkoutRepository workoutRepository;
  GetPlanSessions({required this.workoutRepository});
  Future<List<PlanSessions>> call(String planId) async {
    return workoutRepository.getPlanSessions(planId);
  }
}
