import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/auth/domain/repositories/auth_repository.dart';

class LogoutUseCase {
  final AuthRepository authRepository;
  LogoutUseCase({required this.authRepository});

  Future<Result<bool>> call(String token) async {
    return authRepository.logout(token);
  }
}
