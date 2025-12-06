import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/user_plan_repository.dart';

class GetUserPlanSessions {
  final UserPlanRepository userRepository;
  GetUserPlanSessions({required this.userRepository});

  Future<Result<List<SessionEntity>>> call(String token, String planId) async {
    return userRepository.getUserPlanSessions(token, planId);
  }
}
