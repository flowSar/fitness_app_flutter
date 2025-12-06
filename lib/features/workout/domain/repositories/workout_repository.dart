import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_session_workout_exercises_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/sessions_plan_entity.dart';

abstract class WorkoutRepository {
  Future<List<PlanEntity>> getPlans();

  Future<List<PlanSessions>> getPlanSessions(String planId);

  Future<PlanSessionWorkoutExercises> getPlanSessionWorkoutExercises(
      String planId, String sessionId);

  Future<void> insertPlan(PlanEntity plan);

  Future<void> insertExercise(Exercise exercise);

  Future<void> insertPlanSessions(String planId);

  Future<void> insertPlanSessionWorkoutExercises(
      String planId, String sessionId, List<Exercise> exercises);
}
