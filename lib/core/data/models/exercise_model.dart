import 'package:w_allfit/core/domain/entities/exercise_entity.dart';

class ExerciseModel extends ExerciseEntity {
  ExerciseModel({
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

  // ---------- FACTORIES ----------
  factory ExerciseModel.fromJson(Map<String, dynamic> json) {
    return ExerciseModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      sets: json['sets'] ?? 1,
      reps: json['reps'] ?? 1,
      duration: json['duration'] ?? 0,
      notes: json['notes'] ?? '',
      level: json['level'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
    );
  }

  factory ExerciseModel.fromEntity(ExerciseEntity entity) {
    return ExerciseModel(
      id: entity.id,
      name: entity.name,
      description: entity.description,
      sets: entity.sets,
      reps: entity.reps,
      duration: entity.duration,
      notes: entity.notes,
      level: entity.level,
      image: entity.image,
      video: entity.video,
    );
  }

  // ---------- METHODS ----------
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'sets': sets,
      'reps': reps,
      'duration': duration,
      'notes': notes,
      'level': level,
      'image': image,
      'video': video,
    };
  }

  ExerciseEntity toEntity() {
    return ExerciseEntity(
      id: id,
      name: name,
      description: description,
      sets: sets,
      reps: reps,
      duration: duration,
      notes: notes,
      level: level,
      image: image,
      video: video,
    );
  }
}
