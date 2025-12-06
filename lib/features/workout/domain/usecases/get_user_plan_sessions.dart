import 'package:w_allfit/features/workout/domain/repositories/user_plan_repository.dart';

class GetUserPlanSessions {
  final UserPlanRepository userRepository;
  GetUserPlanSessions({required this.userRepository});

  Future<void> call(String userId, String planId) async {
    return userRepository.getUserPlanSessions(userId, planId);
  }
}
