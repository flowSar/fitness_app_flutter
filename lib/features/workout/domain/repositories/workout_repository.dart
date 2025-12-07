import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/core/domain/entities/plan_entity.dart';

abstract class WorkoutRepository {
  Future<List<PlanEntity>> getPlans();

  Future<void> insertPlan(PlanEntity plan);

  Future<void> insertExercise(ExerciseEntity exercise);

  Future<void> insertPlanSessions(String planId);

  Future<void> insertPlanSessionWorkoutExercises(
      String planId, String sessionId, List<ExerciseEntity> exercises);
}
