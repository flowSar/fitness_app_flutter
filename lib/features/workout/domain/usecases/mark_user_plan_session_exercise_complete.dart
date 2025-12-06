import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/workout/domain/entities/session_exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/user_plan_repository.dart';

class MarkUserPlanSessionExerciseComplete {
  final UserPlanRepository userPlanRepository;

  MarkUserPlanSessionExerciseComplete({required this.userPlanRepository});

  Future<Result<SessionExerciseEntity>> call(
      String token, String sessionExerciseId) {
    return userPlanRepository.markUserPlansessionExerciseComplete(
        token, sessionExerciseId);
  }
}
