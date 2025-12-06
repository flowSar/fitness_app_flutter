class SessionEntity {
  final String id;
  final String name;
  final bool complete;
  final double progress;
  final double duration;
  final String planId;

  SessionEntity({
    required this.id,
    required this.name,
    required this.complete,
    required this.progress,
    required this.duration,
    required this.planId,
  });
}
