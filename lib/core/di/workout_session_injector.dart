import 'package:get_it/get_it.dart';
import 'package:w_allfit/features/workout/data/datasources/remote/workout_remote_datasource.dart';
import 'package:w_allfit/features/workout/data/datasources/remote/workout_remote_datasource_impl.dart';
import 'package:w_allfit/features/workout/data/repositories/workout_repository_impl.dart';
import 'package:w_allfit/features/workout/domain/repositories/workout_repository.dart';
import 'package:w_allfit/features/workout/domain/usecases/get_plan_session_exercises_usecase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_bloc.dart';

final sl = GetIt.instance;

void singleWorkoutSession() {
  sl.registerSingleton<WorkoutRemoteDatasource>(WorkoutRemoteDatasourceImpl());

// register respository
  sl.registerSingleton<WorkoutRepository>(WorkoutRepositoryImpl(
      workoutRemoteDatasource: sl<WorkoutRemoteDatasource>()));

  // register usecase
  sl.registerSingleton<GetPlanSessionExercisesUsecase>(
      GetPlanSessionExercisesUsecase(
          workoutRepository: sl<WorkoutRepository>()));

  // bloc

  sl.registerFactory<WorkoutSessionBloc>(() => WorkoutSessionBloc(
      getPlanSessionExercisesUsecase: sl<GetPlanSessionExercisesUsecase>()));
}
