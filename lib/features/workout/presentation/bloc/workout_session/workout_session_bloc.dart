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
    final workoutExercises = FakeDatabase.session_workout_plan
        .where((plan) => plan['session_id'] == sessionId)
        .toList();
    final List<Map<String, Object>> exercises = FakeDatabase.exercises;
    late Map<String, Object> startExercise = exercises[0];
    int index = 0;
    // loop through session workout plan and find incomplete exercises
    for (final exercise in workoutExercises) {
      //if the exercise is incomplete , get the exercise id and find it by index hch id id - 1.

      if (exercise['complete'] as bool == false) {
        // index = exercise['exercise_id'] as int;
        startExercise = exercises[index];
        break;
      }
      index++;
    }
    // if all exercises complete start from first exercise
    if (index >= workoutExercises.length) {
      emit(WorkoutExerciseInProgress(
          exercise: exercises[0], sessionId: sessionId, index: 0));
    } else {
      emit(WorkoutExerciseInProgress(
          exercise: startExercise, sessionId: sessionId, index: index));
    }
  }

  void _nextWorkoutExercise(NextWorkoutExercise event, emit) {
    // get index + 1 = nextIndex
    final nextIndex = (state as WorkoutExerciseInProgress).index + 1;
    // get sessionId
    final sessionId = (state as WorkoutExerciseInProgress).sessionId;
    // get all workoutExercises for the current session
    final workoutExercises = FakeDatabase.session_workout_plan
        .where((plan) => plan['session_id'] == sessionId)
        .toList();
    if (nextIndex >= workoutExercises.length) {
      emit(WorkoutComplete());
    }
    // make previous exercise complete
    workoutExercises[nextIndex - 1]['complete'] = true;
    // get the next exercise
    final exerciseId = workoutExercises[nextIndex]['exercise_id'] as int;
    final exercise = FakeDatabase.exercises[exerciseId - 1];
    emit(WorkoutExerciseInProgress(
        exercise: exercise, sessionId: sessionId, index: nextIndex));
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
        .toList()[0];
    session['progress'] = progress.round();
    emit(WorkoutSessionProgress(progress: progress));
  }
}
