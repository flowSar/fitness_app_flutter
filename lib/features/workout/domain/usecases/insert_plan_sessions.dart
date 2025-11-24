import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class InsertPlanSessions {
  final WorkoutRepository workoutRepository;
  InsertPlanSessions({required this.workoutRepository});

  Future<void> call(String planId) {
    return workoutRepository.insertPlanSessions(planId);
  }
}
