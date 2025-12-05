import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/auth/domain/entities/user_entity.dart';
import 'package:w_allfit/features/auth/domain/repositories/auth_repository.dart';

class IsUserAuthenticatedUsecase {
  final AuthRepository authRepository;

  IsUserAuthenticatedUsecase({required this.authRepository});

  Future<Result<UserEntity>> call(String token) async {
    return authRepository.isUserAuthenticated(token);
  }
}
