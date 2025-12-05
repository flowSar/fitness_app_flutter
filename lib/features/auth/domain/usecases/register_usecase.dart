import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/auth/domain/entities/user_entity.dart';
import 'package:w_allfit/features/auth/domain/repositories/auth_repository.dart';

class RegisterUseCase {
  final AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Result<UserEntity>> call(UserEntity user) async {
    return authRepository.register(user);
  }
}
