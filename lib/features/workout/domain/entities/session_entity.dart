class Session {
  final String id;
  final int dayNumber;
  final bool complete;
  final int progress;
  final int duration;
  final String planId;

  Session({
    required this.id,
    required this.dayNumber,
    required this.complete,
    required this.progress,
    required this.duration,
    required this.planId,
  });
}
