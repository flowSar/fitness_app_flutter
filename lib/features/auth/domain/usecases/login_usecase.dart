import 'package:w_allfit/core/result.dart';
import 'package:w_allfit/features/auth/domain/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository authRepository;

  LoginUseCase({required this.authRepository});

  Future<Result<String>> call(String email, String password) async {
    return authRepository.login(email, password);
  }
}
