import 'package:w_allfit/core/constants/plansType.dart';

class Exercise {
  final String id;
  final String name;
  final String description;
  final WorkoutLevel level;
  final String image;
  final String? video;
  final String category;

  Exercise({
    required this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.image,
    required this.video,
    required this.category,
  });
}
