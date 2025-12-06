import 'package:w_allfit/features/workout/domain/repositories/user_plan_repository.dart';

class InsertUserPlan {
  final UserPlanRepository userRepository;
  InsertUserPlan({required this.userRepository});

  Future<void> call(String userId, String planId) async {
    return userRepository.insertUserPlan(userId, planId);
  }
}
