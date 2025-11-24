import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/user_repository.dart';

class GetUserPlans {
  final UserRepository userRepository;
  GetUserPlans({required this.userRepository});

  Future<List<Plan>> call(String userId) {
    return userRepository.getUserPlans(userId);
  }
}
