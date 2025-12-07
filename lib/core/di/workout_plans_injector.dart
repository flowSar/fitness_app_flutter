import 'package:get_it/get_it.dart';
import 'package:w_allfit/features/explore/data/datasources/workout_plan_remote_data_source_impl.dart';
import 'package:w_allfit/features/explore/data/datasources/workout_plans_remote_data_source.dart';
import 'package:w_allfit/features/explore/data/repositories/workout_plans_repository_impl.dart';
import 'package:w_allfit/features/explore/domain/repositories/workout_plans_repository.dart';
import 'package:w_allfit/features/explore/domain/usecases/get_all_workout_plans_usecase.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_bloc.dart';

final sl = GetIt.instance;

void workoutPlansInit() {
  // data source register
  sl.registerSingleton<WorkoutPlansRemoteDataSource>(
    WorkoutPlansRemoteDataSourceImpl(),
  );
  // repository register
  sl.registerSingleton<WorkoutPlansRepository>(
    WorkoutPlansRepositoryImpl(
      workoutPlansRemoteDataSource: sl<WorkoutPlansRemoteDataSource>(),
    ),
  );

  // usecase register
  sl.registerSingleton<GetAllWorkoutPlansUsecase>(GetAllWorkoutPlansUsecase(
    workoutPlansRepository: sl<WorkoutPlansRepository>(),
  ));

  // bloc register
  sl.registerFactory<WorkoutPlansBloc>(() => WorkoutPlansBloc(
        getAllWorkoutPlansUsecase: sl<GetAllWorkoutPlansUsecase>(),
      ));
}
