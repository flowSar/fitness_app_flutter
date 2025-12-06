import 'package:get_it/get_it.dart';
import 'package:w_allfit/features/workout/data/datasources/remote/user_remote_datasource.dart';
import 'package:w_allfit/features/workout/data/datasources/remote/user_remote_datasource_impl.dart';
import 'package:w_allfit/features/workout/data/repositories/user_plan_repository_impl.dart';
import 'package:w_allfit/features/workout/domain/repositories/user_plan_repository.dart';
import 'package:w_allfit/features/workout/domain/usecases/get_user_plan_sessions.dart';
import 'package:w_allfit/features/workout/domain/usecases/user_plans_usecase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plans_bloc.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_bloc.dart';

final sl = GetIt.instance;

void userWorkoutPlansInit() {
  sl.registerSingleton<UserRemoteDataSource>(
    UserRemoteDataSourceImpl(),
  );

  sl.registerSingleton<UserPlanRepository>(
    UserPlanRepositoryImpl(
      userRemoteDataSource: sl<UserRemoteDataSource>(),
    ),
  );

  sl.registerSingleton<UserPlansUsecase>(
    UserPlansUsecase(
      userRepository: sl<UserPlanRepository>(),
    ),
  );

  sl.registerSingleton<GetUserPlanSessions>(
      GetUserPlanSessions(userRepository: sl<UserPlanRepository>()));

  sl.registerFactory<UserPlansBloc>(
    () => UserPlansBloc(
      userPlansUsecase: sl<UserPlansUsecase>(),
    ),
  );

  sl.registerFactory<PlanSessionsBloc>(
    () => PlanSessionsBloc(
      getUserPlanSessions: sl<GetUserPlanSessions>(),
    ),
  );
}
