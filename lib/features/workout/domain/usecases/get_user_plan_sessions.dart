import 'package:w_allfit/features/workout/domain/repositories/user_repository.dart';

class GetUserPlanSessions {
  final UserRepository userRepository;
  GetUserPlanSessions({required this.userRepository});

  Future<void> call(String userId, String planId) async {
    return userRepository.getUserPlanSessions(userId, planId);
  }
}
