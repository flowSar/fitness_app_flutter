import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  @override
  Future<List<PlanEntity>> getPlans() {
    // TODO: implement getPlans
    throw UnimplementedError();
  }

  @override
  Future<void> insertExercise(ExerciseEntity exercise) {
    // TODO: implement insertExercise
    throw UnimplementedError();
  }

  @override
  Future<void> insertPlan(PlanEntity plan) {
    // TODO: implement insertPlan
    throw UnimplementedError();
  }

  @override
  Future<void> insertPlanSessionWorkoutExercises(
      String planId, String sessionId, List<ExerciseEntity> exercises) {
    // TODO: implement insertPlanSessionWorkoutExercises
    throw UnimplementedError();
  }

  @override
  Future<void> insertPlanSessions(String planId) {
    // TODO: implement insertPlanSessions
    throw UnimplementedError();
  }
}
