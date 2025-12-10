import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/workout/data/datasources/remote/workout_remote_datasource.dart';
import 'package:w_allfit/features/workout/data/models/exercise_model.dart';
import 'package:w_allfit/features/workout/domain/entities/exercise_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';

class WorkoutRepositoryImpl implements WorkoutRepository {
  final WorkoutRemoteDatasource workoutRemoteDatasource;

  WorkoutRepositoryImpl({required this.workoutRemoteDatasource});

  @override
  Future<Result<List<ExerciseEntity>>> getPlanSessionExercises(
      String token, String planId) async {
    try {
      final data =
          await workoutRemoteDatasource.getPlanSessionExercises(token, planId);
      final exercises =
          data.map((element) => ExerciseModel.fromJson(element)).toList();
      return Result.success(exercises);
    } catch (e) {
      print('faetching eercses failed ${e.toString()}');
      return Result.failure(e.toString());
    }
  }
}
