import 'package:w_allfit/core/domain/entities/exercise_entity.dart';
import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/user_workout/domain/repositories/user_plan_repository.dart';

class CreateUserPlanUsecase {
  final UserPlanRepository userPlanRepository;

  CreateUserPlanUsecase({required this.userPlanRepository});

  Future<Result<PlanEntity>> call(String token, String planName,
      bool visibility, List<ExerciseEntity> exercises) {
    return userPlanRepository.createUserPlan(
        token, planName, visibility, exercises);
  }
}
