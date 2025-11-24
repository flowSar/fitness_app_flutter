import 'package:w_allfit/features/workout/domain/entities/workout_session_exercises_entity.dart';

class WorkoutSessionExercisesModel extends WorkoutSessionExercises {
  WorkoutSessionExercisesModel(
      {required super.id,
      required super.sessionId,
      required super.complete,
      required super.sets,
      required super.reps,
      required super.duration,
      required super.exerciseId});
}
