import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class InsertExercises {
  final WorkoutRepository workoutRepository;
  InsertExercises({required this.workoutRepository});

  Future<void> call(Exercise exercise) {
    return workoutRepository.insertExercise(exercise);
  }
}
