import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/workout/domain/usecases/mark_user_plan_session_exercise_complete.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_state.dart';

class WorkoutSessionBloc
    extends Bloc<WorkoutSessionEvent, WorkoutSessionState> {
  final MarkUserPlanSessionExerciseComplete markUserPlanSessionExerciseComplete;
  WorkoutSessionBloc({required this.markUserPlanSessionExerciseComplete})
      : super(WorkoutSessionInitialState()) {
    on<StartWorkout>(_startWorkingOut);
    on<NextWorkoutExercise>(_nextWorkoutExercise);
    on<UpdateWorkoutSessionProgress>(_updateWorkoutSessionProgress);
  }

  void _startWorkingOut(StartWorkout event, emit) {
    final workoutPlan = event.workoutPlan;
    emit(WorkoutExerciseInProgressLoading());
    late int index = 0;
    for (final exercise in workoutPlan) {
      if (exercise.complete == false) {
        break;
      }
      index++;
    }
    if (index >= workoutPlan.length) {
      index = 0;
    }
    emit(WorkoutExerciseInProgress(
        workoutPlan: workoutPlan, exercise: workoutPlan[index], index: index));
  }

  void _nextWorkoutExercise(NextWorkoutExercise event, emit) {
    // get index + 1 = nextIndex
    final nextIndex = (state as WorkoutExerciseInProgress).index + 1;
    // get sessionId
    final workoutPlan = (state as WorkoutExerciseInProgress).workoutPlan;

    _markSessionComplete(workoutPlan[nextIndex - 1].id);

    if (nextIndex >= workoutPlan.length) {
      emit(WorkoutComplete());
    }

    final exercise = workoutPlan[nextIndex];
    emit(
      WorkoutExerciseInProgress(
        exercise: exercise,
        workoutPlan: workoutPlan,
        index: nextIndex,
      ),
    );
  }

  void _updateWorkoutSessionProgress(UpdateWorkoutSessionProgress event, emit) {
    final int sessionId = event.sessionId;
  }

  void _markSessionComplete(String exerciseSessionId) async {
    final String? token = await hasToken();
    if (token != null) {
      final result =
          await markUserPlanSessionExerciseComplete(token, exerciseSessionId);
      if (result.isSuccess) {
        print('exercise marked complete successfully');
      } else {
        print('exercise marked complete failed');
      }
    }
  }

  bool _isWorkoutSessionPlanComplete(int sessionId, planId) {
    return true;
  }
}
