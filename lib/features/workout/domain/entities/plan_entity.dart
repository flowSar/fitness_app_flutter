import 'package:w_allfit/core/constants/plansType.dart';

class Plan {
  final String id;
  final String name;
  final String description;
  final String level;
  final String image;
  final String? video;
  final int duration;
  final int sessionsNumber;
  final PlanType type;

  Plan(
      {required this.id,
      required this.name,
      required this.description,
      required this.level,
      required this.image,
      required this.video,
      required this.duration,
      required this.sessionsNumber,
      required this.type});
}
