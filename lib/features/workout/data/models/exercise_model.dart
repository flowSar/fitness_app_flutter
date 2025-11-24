import 'package:w_allfit/features/workout/data/models/plan_model.dart';
import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';

class ExerciseModel extends Exercise {
  ExerciseModel(
      {required super.id,
      required super.name,
      required super.description,
      required super.level,
      required super.image,
      required super.video,
      required super.category});
}
