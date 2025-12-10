import 'package:w_allfit/features/workout/data/models/exercise_model.dart';
import 'package:w_allfit/features/workout/domain/entities/session_exercise_entity.dart';

class SessionExerciseModel extends SessionExerciseEntity {
  SessionExerciseModel({
    required super.id,
    required super.complete,
    required super.exercise,
  });

  factory SessionExerciseModel.fromJson(Map<String, dynamic> json) {
    return SessionExerciseModel(
        id: json['id'] ?? '',
        complete: json['complete'] ?? false,
        exercise: ExerciseModel(
          id: json['exercise']['id'] ?? '',
          name: json['exercise']['name'] ?? '',
          description: json['exercise']['description'] ?? '',
          sets: json['exercise']['sets'] ?? 0,
          reps: json['exercise']['reps'] ?? 0,
          duration: json['exercise']['duration'] ?? 0,
          notes: json['exercise']['notes'] ?? '',
          level: json['exercise']['level'] ?? '',
          image: json['exercise']['image'] ?? '',
        ));
  }

  factory SessionExerciseModel.fromEntity(
      SessionExerciseEntity sessionExercise) {
    return SessionExerciseModel(
        id: sessionExercise.id,
        complete: sessionExercise.complete,
        exercise: ExerciseModel(
          id: sessionExercise.exercise.id,
          name: sessionExercise.exercise.name,
          description: sessionExercise.exercise.description,
          sets: sessionExercise.exercise.sets,
          reps: sessionExercise.exercise.reps,
          duration: sessionExercise.exercise.duration,
          notes: sessionExercise.exercise.name,
          level: sessionExercise.exercise.level,
          image: sessionExercise.exercise.image,
        ));
  }
}
