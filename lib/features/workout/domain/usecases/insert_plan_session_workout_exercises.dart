import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class InsertPlanSessionWorkoutExercises {
  final WorkoutRepository workoutRepository;
  InsertPlanSessionWorkoutExercises({required this.workoutRepository});

  Future<void> call(String planId, String sessionId, List<Exercise> exercises) {
    return workoutRepository.insertPlanSessionWorkoutExercises(
        planId, sessionId, exercises);
  }
}
