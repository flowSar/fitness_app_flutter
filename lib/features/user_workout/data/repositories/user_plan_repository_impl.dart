import 'package:w_allfit/core/data/models/exercise_model.dart';
import 'package:w_allfit/core/domain/entities/exercise_entity.dart';
import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/user_workout/data/datasources/remote/user_remote_datasource.dart';
import 'package:w_allfit/features/user_workout/data/models/user_plan_model.dart';
import 'package:w_allfit/features/user_workout/domain/repositories/user_plan_repository.dart';
import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';
import 'package:w_allfit/features/workout/data/models/session_model.dart';
import 'package:w_allfit/core/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/session_exercise_entity.dart';

class UserPlanRepositoryImpl extends UserPlanRepository {
  final UserRemoteDataSource userRemoteDataSource;
  UserPlanRepositoryImpl({required this.userRemoteDataSource});
  @override
  Future<Result<List<PlanEntity>>> getUserPlans(String token) async {
    try {
      final List<Map<String, dynamic>> data =
          await userRemoteDataSource.getUserWorkoutPlans(token);
      print('data: $data');
      final List<UserPlanModel> plans =
          data.map((elem) => UserPlanModel.fromJson(elem)).toList();
      print('data: $plans');
      return Result.success(plans);
    } catch (e) {
      print('loding user plans failed ${e.toString()}');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<SessionEntity>>> getUserPlanSessions(
      String token, String planId) async {
    try {
      final List<Map<String, dynamic>> data =
          await userRemoteDataSource.getuserPlanSessions(token, planId);

      final List<SessionModel> plans =
          data.map((elem) => SessionModel.fromJson(elem)).toList();

      return Result.success(plans);
    } catch (e) {
      print('loding user plans failed ${e.toString()}');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<SessionExerciseEntity>>> getUserPlanSessionExercises(
      String token, String sessionId) async {
    try {
      final List<Map<String, dynamic>> data = await userRemoteDataSource
          .getUserPlanSessionExercises(token, sessionId);

      final List<SessionExerciseModel> plans =
          data.map((elem) => SessionExerciseModel.fromJson(elem)).toList();

      return Result.success(plans);
    } catch (e) {
      print('loding user plans failed ${e.toString()}');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<SessionExerciseEntity>> markUserPlansessionExerciseComplete(
      String token, String sessionExerciseId) async {
    try {
      final Map<String, dynamic> data = await userRemoteDataSource
          .markUserPlansessionExerciseComplete(token, sessionExerciseId);
      print('updateddata: $data');
      final SessionExerciseModel plan = SessionExerciseModel.fromJson(data);
      print('updateddata: $plan');
      return Result.success(plan);
    } catch (e) {
      print('markt exercise comlete failed ${e.toString()}');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<SessionEntity>> markUserPlansessionComplete(
      String token, String sessionId) {
    // TODO: implement markUserPlansessionComplete
    throw UnimplementedError();
  }

  @override
  Future<Result<PlanEntity>> adduserPlan(String token, String planId) async {
    try {
      final data = await userRemoteDataSource.addUserPlan(token, planId);
      print('userr created plan $data');
      final plan = UserPlanModel.fromJson(data);

      return Result.success(plan);
    } catch (e) {
      print('add User plan failed $token ${e.toString()}');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<List<ExerciseEntity>>> getAllExercises(String token) async {
    try {
      final data = await userRemoteDataSource.getAllExercises(token);
      final exercises = data
          .map((exerciseJson) => ExerciseModel.fromJson(exerciseJson))
          .toList();
      return Result.success(exercises);
    } catch (e) {
      print('loading exercise failed ${e.toString()}');
      return Result.failure(e.toString());
    }
  }
}
