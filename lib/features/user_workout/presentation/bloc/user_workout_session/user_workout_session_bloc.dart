import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/mark_user_plan_session_exercise_complete.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session/user_workout_session_state.dart';

class UserWorkoutSessionBloc
    extends Bloc<UserWorkoutSessionEvent, UserWorkoutSessionState> {
  final MarkUserPlanSessionExerciseComplete markUserPlanSessionExerciseComplete;
  UserWorkoutSessionBloc({required this.markUserPlanSessionExerciseComplete})
      : super(UserWorkoutSessionInitialState()) {
    on<StartUserWorkout>(_startWorkingOut);
    on<NextUserWorkoutExercise>(_nextWorkoutExercise);
  }

  void _startWorkingOut(StartUserWorkout event, emit) {
    final workoutPlan = event.workoutPlan;
    emit(UserWorkoutExerciseInProgressLoading());
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
    emit(UserWorkoutExerciseInProgress(
        workoutPlan: workoutPlan, exercise: workoutPlan[index], index: index));
  }

  void _nextWorkoutExercise(NextUserWorkoutExercise event, emit) {
    // get index + 1 = nextIndex
    final nextIndex = (state as UserWorkoutExerciseInProgress).index + 1;
    // get sessionId
    final workoutPlan = (state as UserWorkoutExerciseInProgress).workoutPlan;

    _markSessionComplete(workoutPlan[nextIndex - 1].id);

    if (nextIndex >= workoutPlan.length) {
      emit(UserWorkoutComplete());
    }

    final exercise = workoutPlan[nextIndex];
    emit(
      UserWorkoutExerciseInProgress(
        exercise: exercise,
        workoutPlan: workoutPlan,
        index: nextIndex,
      ),
    );
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
}
