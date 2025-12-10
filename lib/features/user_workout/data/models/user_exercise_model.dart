import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';

class UserExerciseModel extends ExerciseEntity {
  UserExerciseModel({
    required super.id,
    required super.name,
    required super.description,
    required super.sets,
    required super.reps,
    required super.duration,
    required super.notes,
    required super.level,
    required super.image,
    super.video,
  });
}
