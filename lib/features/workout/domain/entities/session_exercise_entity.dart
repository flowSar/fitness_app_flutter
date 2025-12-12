import 'package:w_allfit/core/domain/entities/exercise_entity.dart';

class SessionExerciseEntity {
  final String id;
  final bool complete;
  final ExerciseEntity exercise;

  SessionExerciseEntity(
      {required this.id, required this.complete, required this.exercise});
}
