import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class GetPlanSessionExercisesUsecase {
  final WorkoutRepository workoutRepository;
  GetPlanSessionExercisesUsecase({required this.workoutRepository});

  Future<Result<List<ExerciseEntity>>> call(String token, String planId) async {
    return workoutRepository.getPlanSessionExercises(token, planId);
  }
}
