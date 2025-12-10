import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/auth/data/datasource/auth_remote_datasource_impl.dart';
import 'package:w_allfit/features/auth/data/models/user_model.dart';
import 'package:w_allfit/features/auth/domain/entities/user_entity.dart';
import 'package:w_allfit/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl extends AuthRepository {
  final AuthRemoteDatasource authRemoteDatasource;
  AuthRepositoryImpl({required this.authRemoteDatasource});
  @override
  Future<Result<String>> login(String email, String password) async {
    try {
      final result = await authRemoteDatasource.login(email, password);
      return Result.success(result['data']['token']);
    } catch (e) {
      print('log in failed: ${e.toString()}');
      return Result.failure('error');
    }
  }

  @override
  Future<Result<bool>> logout(String token) async {
    try {
      final data = await authRemoteDatasource.logout(token);
      return Result.success(data['success']);
    } catch (e) {
      print('log out error ${e.toString()}');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<UserEntity>> register(UserEntity user) async {
    try {
      final data =
          await authRemoteDatasource.register(UserModel.fromEntity(user));
      return Result.success(UserModel.fromJson(data['user'], data['token']));
    } catch (e) {
      print('register failed: ${e.toString()}');
      return Result.failure(e.toString());
    }
  }

  @override
  Future<Result<UserEntity>> isUserAuthenticated(String token) async {
    try {
      final data = await authRemoteDatasource.isUserAuthenticated(token);

      return Result.success(
        UserModel.fromJson(data['user'], null),
      );
    } catch (e) {
      print('token validation error catch: ${e.toString()}');
      return Result.failure(e.toString());
    }
  }
}
