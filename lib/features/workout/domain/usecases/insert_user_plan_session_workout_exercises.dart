import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/user_repository.dart';

class InsertUserPlanSessionWorkoutExercises {
  final UserRepository userRepository;
  InsertUserPlanSessionWorkoutExercises({required this.userRepository});

  Future<void> call(String userId, String planId, String sessionId,
      List<Exercise> exercises) {
    return userRepository.insertUserPlanSessionWorkoutExercises(
        userId, planId, sessionId, exercises);
  }
}
