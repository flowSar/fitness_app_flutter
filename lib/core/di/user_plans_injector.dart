import 'package:get_it/get_it.dart';
import 'package:w_allfit/features/workout/data/datasources/remote/user_remote_datasource.dart';
import 'package:w_allfit/features/workout/data/datasources/remote/user_remote_datasource_impl.dart';
import 'package:w_allfit/features/workout/data/repositories/user_plan_repository_impl.dart';
import 'package:w_allfit/features/workout/domain/repositories/user_plan_repository.dart';
import 'package:w_allfit/features/workout/domain/usecases/add_user_plan_usecase.dart';
import 'package:w_allfit/features/workout/domain/usecases/get_user_plan_session_exercises.dart';
import 'package:w_allfit/features/workout/domain/usecases/get_user_plan_sessions.dart';
import 'package:w_allfit/features/workout/domain/usecases/mark_user_plan_session_exercise_complete.dart';
import 'package:w_allfit/features/workout/domain/usecases/user_plans_usecase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session_plan/workout_session_plan_bloc.dart';

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

  sl.registerSingleton<UserPlansUsecase>(
    UserPlansUsecase(
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

  // bloc register

  sl.registerFactory<UserPlansBloc>(
    () => UserPlansBloc(
      userPlansUsecase: sl<UserPlansUsecase>(),
      addUserPlanUsecase: sl<AddUserPlanUsecase>(),
    ),
  );

  sl.registerFactory<PlanSessionsBloc>(
    () => PlanSessionsBloc(
      getUserPlanSessions: sl<GetUserPlanSessions>(),
    ),
  );

  sl.registerFactory<WorkoutSessionPlanBloc>(
    () => WorkoutSessionPlanBloc(
      getUserPlanSessionExercises: sl<GetUserPlanSessionExercises>(),
    ),
  );

  sl.registerFactory<WorkoutSessionBloc>(() => WorkoutSessionBloc(
      markUserPlanSessionExerciseComplete:
          sl<MarkUserPlanSessionExerciseComplete>()));
}
