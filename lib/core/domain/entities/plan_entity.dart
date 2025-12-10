class PlanEntity {
  final String id;
  final String name;
  final String description;
  final String level;
  final String image;
  final String? video;
  final int duration;
  final int sessionsNumber;
  final bool? complete;
  final double? progress;
  final String type;

  PlanEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.level,
    required this.image,
    required this.video,
    required this.duration,
    required this.sessionsNumber,
    this.complete,
    this.progress,
    required this.type,
  });
}
