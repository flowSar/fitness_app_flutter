import 'package:w_allfit/core/domain/entities/exercise_entity.dart';
import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/user_workout/domain/repositories/user_plan_repository.dart';

class GetAllExercisesUsecase {
  final UserPlanRepository userPlanRepository;
  GetAllExercisesUsecase({required this.userPlanRepository});

  Future<Result<List<ExerciseEntity>>> call(String token) {
    return userPlanRepository.getAllExercises(token);
  }
}
