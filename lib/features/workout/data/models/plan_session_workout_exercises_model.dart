import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_session_workout_exercises_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';

class PlanSessionWorkoutExercisesModel extends PlanSessionWorkoutExercises {
  PlanSessionWorkoutExercisesModel(
      {required super.plan, required super.session, required super.exercises});
}
