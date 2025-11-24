import 'package:w_allfit/features/workout/domain/entities/plan_session_workout_exercises_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class GetSessionWorkoutExercises {
  final WorkoutRepository workoutRepository;
  GetSessionWorkoutExercises({required this.workoutRepository});

  Future<PlanSessionWorkoutExercises> call(
      String planId, String sessionId) async {
    return workoutRepository.getPlanSessionWorkoutExercises(planId, sessionId);
  }
}
