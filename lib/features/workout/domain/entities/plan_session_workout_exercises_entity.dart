import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';

class PlanSessionWorkoutExercises {
  final PlanEntity plan;
  final SessionEntity session;
  final List<Exercise> exercises;
  PlanSessionWorkoutExercises(
      {required this.plan, required this.session, required this.exercises});
}
