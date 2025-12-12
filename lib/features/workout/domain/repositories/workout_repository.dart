import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/core/domain/entities/exercise_entity.dart';

abstract class WorkoutRepository {
  Future<Result<List<ExerciseEntity>>> getPlanSessionExercises(
    String token,
    String planId,
  );
}
