import 'package:w_allfit/features/workout/domain/repositories/user_repository.dart';

class InsertUserPlan {
  final UserRepository userRepository;
  InsertUserPlan({required this.userRepository});

  Future<void> call(String userId, String planId) async {
    return userRepository.insertUserPlan(userId, planId);
  }
}
