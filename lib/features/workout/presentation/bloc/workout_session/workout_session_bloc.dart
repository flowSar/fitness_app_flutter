import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session/workout_session_state.dart';

class WorkoutSessionBloc
    extends Bloc<WorkoutSessionEvent, WorkoutSessionState> {
  WorkoutSessionBloc() : super(WorkoutSessionInitialState()) {
    on<StartWorkout>(_startWorkingOut);
    on<NextWorkoutExercise>(_nextWorkoutExercise);
    on<UpdateWorkoutSessionProgress>(_updateWorkoutSessionProgress);
  }

  void _startWorkingOut(StartWorkout event, emit) {
    final sessionId = event.sessionId;
    final sessionExercises = FakeDatabase.session_workout_plan
        .where((plan) => plan['session_id'] == sessionId)
        .toList();
    final List<Map<String, Object>> exercises = FakeDatabase.exercises;
    late Map<String, Object> startExercise = exercises[0];
    int index = 0;
    // loop through session workout plan and find incomplete exercises
    for (final exercise in sessionExercises) {
      //if the exercise is incomplete , get the exercise id and find it by index hch id id - 1.

      if (exercise['complete'] as bool == false) {
        // index = exercise['exercise_id'] as int;
        startExercise = exercises[index];
        break;
      }
      index++;
    }
    // if all exercises complete start from first exercise
    if (index >= sessionExercises.length) {
      emit(WorkoutExerciseInProgress(
          exercise: exercises[0],
          sessionExercises: sessionExercises[0],
          sessionId: sessionId,
          index: 0));
    } else {
      emit(WorkoutExerciseInProgress(
          exercise: startExercise,
          sessionExercises: sessionExercises[index],
          sessionId: sessionId,
          index: index));
    }
  }

  void _nextWorkoutExercise(NextWorkoutExercise event, emit) {
    // get index + 1 = nextIndex
    final nextIndex = (state as WorkoutExerciseInProgress).index + 1;
    // get sessionId
    final sessionId = (state as WorkoutExerciseInProgress).sessionId;
    // get all workoutExercises for the current session
    final sessionExercises = FakeDatabase.session_workout_plan
        .where((plan) => plan['session_id'] == sessionId)
        .toList();
    if (nextIndex >= sessionExercises.length) {
      emit(WorkoutComplete());
    }
    // make previous exercise complete
    sessionExercises[nextIndex - 1]['complete'] = true;
    // get the next exercise
    final exerciseId = sessionExercises[nextIndex]['exercise_id'] as int;
    final exercise = FakeDatabase.exercises[exerciseId - 1];
    emit(
      WorkoutExerciseInProgress(
        exercise: exercise,
        sessionExercises: sessionExercises[nextIndex],
        sessionId: sessionId,
        index: nextIndex,
      ),
    );
  }

  void _updateWorkoutSessionProgress(UpdateWorkoutSessionProgress event, emit) {
    final int sessionId = event.sessionId;
    final workoutExercises = FakeDatabase.session_workout_plan
        .where((plan) => plan['session_id'] == sessionId)
        .toList();

    final int length = workoutExercises.length;
    late int completeExercises = 0;
    for (final exercise in workoutExercises) {
      if (exercise['complete'] as bool == true) {
        completeExercises++;
      }
    }
    final double progress = (completeExercises / length) * 100;
    print('----------------progress ${progress}-----------');
    final session = FakeDatabase.sessions
        .where((session) => session['id'] == sessionId)
        .toList();
    if (session.isNotEmpty) {
      session[0]['progress'] = progress.round();
    }

    // if progress 100 I need to mark session as complete
    if (progress == 100) {
      _markSessionComplete(sessionId);
    }
    emit(WorkoutSessionLoaded(progress: progress));
  }

  void _markSessionComplete(int sessionId) {
    final sessions = FakeDatabase.sessions
        .where((session) => session['id'] == sessionId)
        .toList();

    sessions[0]['complete'] = true;
  }

  bool _isWorkoutSessionPlanComplete(int sessionId, planId) {
    final workoutSessionPlan = FakeDatabase.session_workout_plan
        .where((plan) => plan['session_id'] == sessionId)
        .toList();

    for (final exercise in workoutSessionPlan) {
      if (exercise['complete'] as bool == false) {
        return false;
      }
    }
    return true;
  }
}
