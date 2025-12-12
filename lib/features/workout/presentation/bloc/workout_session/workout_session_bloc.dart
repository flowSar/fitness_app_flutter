import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/core/data/models/exercise_model.dart';
import 'package:w_allfit/features/workout/domain/usecases/get_plan_session_exercises_usecase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_state.dart';

class WorkoutSessionBloc
    extends Bloc<WorkoutSessionEvent, WorkoutSessionState> {
  final GetPlanSessionExercisesUsecase getPlanSessionExercisesUsecase;
  WorkoutSessionBloc({required this.getPlanSessionExercisesUsecase})
      : super(WorkoutSessionInitialState()) {
    on<StartWorkout>(_startWorkingOut);
    on<NextWorkoutExercise>(_nextWorkoutExercise);
    on<LoadWorkoutSession>(_loadWorkoutSessionPlan);
  }

  void _startWorkingOut(StartWorkout event, emit) {
    final exercises = event.exercises;
    emit(WorkoutExerciseInProgressLoading());

    emit(WorkoutExerciseInProgress(
        exercises: exercises, exercise: exercises[0], index: 0));
  }

  void _nextWorkoutExercise(NextWorkoutExercise event, emit) {
    // get index + 1 = nextIndex
    final nextIndex = (state as WorkoutExerciseInProgress).index + 1;
    // get sessionId
    final exercises = (state as WorkoutExerciseInProgress).exercises;

    if (nextIndex >= exercises.length) {
      emit(WorkoutComplete());
    }

    final exercise = exercises[nextIndex];
    emit(
      WorkoutExerciseInProgress(
        exercises: exercises,
        exercise: exercise,
        index: nextIndex,
      ),
    );
  }

  void _loadWorkoutSessionPlan(LoadWorkoutSession event, emit) async {
    emit(WorkoutSessionLoading());
    final String planId = event.planId;
    final String? token = await hasToken();
    if (token == null) {
      emit(WorkoutSessionLoadingFailed(error: 'token is missing'));
    }

    final result = await getPlanSessionExercisesUsecase(token!, planId);
    if (!result.isSuccess || result.data == null) {
      emit(WorkoutSessionLoadingFailed(error: '${result.error}'));
    }
    final exercises =
        result.data?.map((elem) => ExerciseModel.fromEntity(elem)).toList();
    emit(WorkoutSessionLoaded(exercises: exercises!));
  }
}
