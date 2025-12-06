import 'package:w_allfit/core/constants/plansType.dart';

class ExerciseEntity {
  final String id;
  final String name;
  final String description;
  final int sets;
  final int reps;
  final int duration;
  final String notes;
  // final WorkoutLevel level;
  final String level;
  final String image;
  final String? video;

  ExerciseEntity(
      {required this.id,
      required this.name,
      required this.description,
      required this.sets,
      required this.reps,
      required this.duration,
      required this.notes,
      required this.level,
      required this.image,
      required this.video});
}
