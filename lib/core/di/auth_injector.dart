import 'package:get_it/get_it.dart';
import 'package:w_allfit/core/di/user_plans_injector.dart';
import 'package:w_allfit/core/di/workout_session_injector.dart';
import 'package:w_allfit/core/di/workout_plans_injector.dart';
import 'package:w_allfit/features/auth/data/datasource/auth_remote_datasource_impl.dart';
import 'package:w_allfit/features/auth/data/respositories/auth_repository_impl.dart';
import 'package:w_allfit/features/auth/domain/repositories/auth_repository.dart';
import 'package:w_allfit/features/auth/domain/usecases/is_user_authenticated_usecase.dart';
import 'package:w_allfit/features/auth/domain/usecases/login_usecase.dart';
import 'package:w_allfit/features/auth/domain/usecases/logout_usecase.dart';
import 'package:w_allfit/features/auth/domain/usecases/register_usecase.dart';
import 'package:w_allfit/features/auth/presentation/bloc/auth_bloc.dart';

final sl = GetIt.instance;

void initializeDependencies() {
  // remote data
  sl.registerSingleton<AuthRemoteDatasource>(
    AuthRemoteDatasourceImpl(),
  );
// repostory
  sl.registerSingleton<AuthRepository>(
    AuthRepositoryImpl(
      authRemoteDatasource: sl<AuthRemoteDatasource>(),
    ),
  );
// use cases
  sl.registerSingleton<LoginUseCase>(
    LoginUseCase(
      authRepository: sl<AuthRepository>(),
    ),
  );

  sl.registerSingleton<RegisterUseCase>(
    RegisterUseCase(
      authRepository: sl<AuthRepository>(),
    ),
  );

  sl.registerSingleton<IsUserAuthenticatedUsecase>(
    IsUserAuthenticatedUsecase(
      authRepository: sl<AuthRepository>(),
    ),
  );
  sl.registerSingleton<LogoutUseCase>(
      LogoutUseCase(authRepository: sl<AuthRepository>()));
// bloc
  sl.registerFactory<AuthBloc>(
    () => AuthBloc(
        registerUseCase: sl<RegisterUseCase>(),
        loginUseCase: sl<LoginUseCase>(),
        isUserAuthenticated: sl<IsUserAuthenticatedUsecase>(),
        logoutUseCase: sl<LogoutUseCase>()),
  );

  userWorkoutPlansInit();
  workoutPlansInit();
  singleWorkoutSession();
}
