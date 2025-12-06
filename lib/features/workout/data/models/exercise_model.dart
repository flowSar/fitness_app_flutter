import 'package:w_allfit/features/workout/data/models/plan_model.dart';
import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  ExerciseModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.sets,
      required super.reps,
      required super.duration,
      required super.notes,
      required super.level,
      required super.image,
      super.video});
}
