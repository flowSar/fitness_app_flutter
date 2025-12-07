import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/workout/domain/repositories/user_plan_repository.dart';

class AddUserPlanUsecase {
  final UserPlanRepository userRepository;
  AddUserPlanUsecase({required this.userRepository});

  Future<Result<PlanEntity>> call(String token, String planId) async {
    return userRepository.adduserPlan(token, planId);
  }
}
