import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/auth/data/models/user_model.dart';
import 'package:w_allfit/features/auth/domain/usecases/is_user_authenticated_usecase.dart';
import 'package:w_allfit/features/auth/domain/usecases/login_usecase.dart';
import 'package:w_allfit/features/auth/domain/usecases/logout_usecase.dart';
import 'package:w_allfit/features/auth/domain/usecases/register_usecase.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_event.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final RegisterUseCase registerUseCase;
  final LoginUseCase loginUseCase;
  final LogoutUseCase logoutUseCase;
  final IsUserAuthenticatedUsecase isUserAuthenticated;

  AuthBloc({
    required this.registerUseCase,
    required this.loginUseCase,
    required this.logoutUseCase,
    required this.isUserAuthenticated,
  }) : super(AuthInitialeState()) {
    on<LogInEvent>(_logIn);
    on<SignUpEvent>(_signUp);
    on<CheckAuthState>(_checkAuthSate);
    on<LogOutEvent>(_logOut);
  }

  void _logIn(LogInEvent event, emit) async {
    emit(LoginLoading());
    final email = event.email;
    final password = event.password;

    final result = await loginUseCase(email, password);
    if (!result.isSuccess) {
      print('login failed------');
      emit(LoginFailed(error: result.error!));
    } else {
      // save token in shared pref
      setToken(result.data!);

      emit(LoginSucess(token: result.data!));
    }
  }

  void _signUp(SignUpEvent event, emit) async {
    emit(SignUpLoading());
    final UserModel user = event.user;
    final result = await registerUseCase(user);
    if (!result.isSuccess) {
      emit(SignUpFailed(error: '${result.error}'));
    }
    emit(SignUpSucess(user: UserModel.fromEntity(result.data!)));
  }

  void _checkAuthSate(event, emit) async {
    final token = await hasToken();

    if (token == null) {
      emit(Authenticated(isAuthenticated: false));
    } else {
      try {
        final result = await isUserAuthenticated(token);

        if (!result.isSuccess) {
          print('auth success false ');
          emit(AuthFailed(error: result.error!));
        }

        emit(Authenticated(
          user: UserModel.fromEntity(result.data!),
          isAuthenticated: true,
        ));
      } catch (e) {
        print("failed-------------- ${e.toString()}");
        emit(AuthFailed(error: e.toString()));
      }
    }
  }

  void _logOut(event, emit) async {
    emit(LogOutLoding());
    final token = await hasToken();
    if (token != null) {
      final result = await logoutUseCase(token);
      if (result.isSuccess) {
        await clearToken();
        emit(LogOutSuccess());
      }
      emit(LogOutFailed(error: 'log out failed ${result.error}'));
    }
    emit(LogOutFailed(error: 'token missing'));
  }
}
