import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/user_workout/domain/repositories/user_plan_repository.dart';

class GetUserPlansUsecase {
  final UserPlanRepository userRepository;
  GetUserPlansUsecase({required this.userRepository});

  Future<Result<List<PlanEntity>>> call(String token) {
    return userRepository.getUserPlans(token);
  }
}
