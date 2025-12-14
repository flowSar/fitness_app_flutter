import 'package:get_it/get_it.dart';
import 'package:w_allfit/features/user_workout/data/datasources/remote/user_remote_datasource.dart';
import 'package:w_allfit/features/user_workout/data/datasources/remote/user_remote_datasource_impl.dart';
import 'package:w_allfit/features/user_workout/data/repositories/user_plan_repository_impl.dart';
import 'package:w_allfit/features/user_workout/domain/repositories/user_plan_repository.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/add_user_plan_usecase.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/create_user_plan_usecase.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/get_all_exercises_usecase.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/get_user_plan_session_exercises.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/get_user_plan_sessions.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/get_user_plans_usecase.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/mark_user_plan_session_exercise_complete.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/exercises/exercises_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/plan_sessions/user_plan_sessions_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plan_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_plans/user_plans_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_bloc.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session_plan/user_workout_session_plan_bloc.dart';

final sl = GetIt.instance;

void userWorkoutPlansInit() {
  // remote data source register
  sl.registerSingleton<UserRemoteDataSource>(
    UserRemoteDataSourceImpl(),
  );

  // repository register

  sl.registerSingleton<UserPlanRepository>(
    UserPlanRepositoryImpl(
      userRemoteDataSource: sl<UserRemoteDataSource>(),
    ),
  );

  // use case register

  sl.registerSingleton<GetUserPlansUsecase>(
    GetUserPlansUsecase(
      userRepository: sl<UserPlanRepository>(),
    ),
  );

  sl.registerSingleton<AddUserPlanUsecase>(AddUserPlanUsecase(
    userRepository: sl<UserPlanRepository>(),
  ));

  sl.registerSingleton<GetUserPlanSessionExercises>(
    GetUserPlanSessionExercises(
      userPlanRepository: sl<UserPlanRepository>(),
    ),
  );

  sl.registerSingleton<GetUserPlanSessions>(
      GetUserPlanSessions(userRepository: sl<UserPlanRepository>()));

  sl.registerSingleton<MarkUserPlanSessionExerciseComplete>(
      MarkUserPlanSessionExerciseComplete(
          userPlanRepository: sl<UserPlanRepository>()));

  sl.registerSingleton<GetAllExercisesUsecase>(
      GetAllExercisesUsecase(userPlanRepository: sl<UserPlanRepository>()));

  sl.registerSingleton<CreateUserPlanUsecase>(
      CreateUserPlanUsecase(userPlanRepository: sl<UserPlanRepository>()));

  // bloc register

  sl.registerFactory<UserPlansBloc>(
    () => UserPlansBloc(
      getUserPlansUsecase: sl<GetUserPlansUsecase>(),
      addUserPlanUsecase: sl<AddUserPlanUsecase>(),
      createUserPlanUsecase: sl<CreateUserPlanUsecase>(),
    ),
  );

  sl.registerFactory<UserPlanSessionsBloc>(
    () => UserPlanSessionsBloc(
      getUserPlanSessions: sl<GetUserPlanSessions>(),
    ),
  );

  sl.registerFactory<UserWorkoutSessionPlanBloc>(
    () => UserWorkoutSessionPlanBloc(
      getUserPlanSessionExercises: sl<GetUserPlanSessionExercises>(),
    ),
  );

  sl.registerFactory<UserWorkoutSessionBloc>(() => UserWorkoutSessionBloc(
      markUserPlanSessionExerciseComplete:
          sl<MarkUserPlanSessionExerciseComplete>()));

  sl.registerFactory<ExercisesBloc>(() => ExercisesBloc(
        getAllExercisesUsecase: sl<GetAllExercisesUsecase>(),
      ));
}
