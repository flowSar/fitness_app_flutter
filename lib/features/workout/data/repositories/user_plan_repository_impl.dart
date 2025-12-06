import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/workout/data/datasources/remote/user_remote_datasource.dart';
import 'package:w_allfit/features/workout/data/models/plan_model.dart';
import 'package:w_allfit/features/workout/data/models/session_model.dart';
import 'package:w_allfit/features/workout/domain/entities/plan_entity.dart';
import 'package:w_allfit/features/workout/domain/entities/session_entity.dart';
import 'package:w_allfit/features/workout/domain/repositories/user_plan_repository.dart';

class UserPlanRepositoryImpl extends UserPlanRepository {
  final UserRemoteDataSource userRemoteDataSource;
  UserPlanRepositoryImpl({required this.userRemoteDataSource});
  @override
  Future<Result<List<PlanEntity>>> getUserPlans(String token) async {
    try {
      final List<Map<String, dynamic>> data =
          await userRemoteDataSource.getUserWorkoutPlans(token);
      print('data: $data');
      final List<PlanModel> plans =
          data.map((elem) => PlanModel.fromJson(elem)).toList();
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
      print('data: $data');
      final List<SessionModel> plans =
          data.map((elem) => SessionModel.fromJson(elem)).toList();
      print('data: $plans');
      return Result.success(plans);
    } catch (e) {
      print('loding user plans failed ${e.toString()}');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<void> getUserPlanSessionWorkoutExercises(
      String userId, String planId, String sessionId) {
    // TODO: implement getUserPlanSessionWorkoutExercises
    throw UnimplementedError();
  }

  @override
  Future<void> insertUserPlan(String userId, String planId) {
    // TODO: implement insertUserPlan
    throw UnimplementedError();
  }
}
