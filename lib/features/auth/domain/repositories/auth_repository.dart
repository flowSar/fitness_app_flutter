import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Result<UserEntity>> register(UserEntity user);
  Future<Result<String>> login(String email, String password);
  Future<Result<bool>> logout(String token);
  Future<Result<UserEntity>> isUserAuthenticated(String token);
}
