import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/user_plan_repository.dart';

class UserPlansUsecase {
  final UserPlanRepository userRepository;
  UserPlansUsecase({required this.userRepository});

  Future<Result<List<PlanEntity>>> call(String token) {
    return userRepository.getUserPlans(token);
  }
}
