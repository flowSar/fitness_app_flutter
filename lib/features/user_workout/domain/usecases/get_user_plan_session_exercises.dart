import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/user_workout/domain/repositories/user_plan_repository.dart';
import 'package:w_allfit/features/workout/domain/entities/session_exercise_entity.dart';

class GetUserPlanSessionExercises {
  final UserPlanRepository userPlanRepository;

  GetUserPlanSessionExercises({required this.userPlanRepository});

  Future<Result<List<SessionExerciseEntity>>> call(
      String token, String sessionId) {
    return userPlanRepository.getUserPlanSessionExercises(token, sessionId);
  }
}
