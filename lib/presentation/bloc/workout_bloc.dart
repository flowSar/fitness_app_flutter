import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/bloc/workout/workout_event.dart';
import 'package:w_allfit/bloc/workout/workout_state.dart';
import 'package:w_allfit/services/database/FakeDatabase.dart';

class WorkoutBloc extends Bloc<WorkoutEvent, WorkoutState> {
  WorkoutBloc() : super(InitialWorkoutStat()) {
    on<StartWorkoutEvent>(_startWorkout);
    on<NextExerciseEvent>(_nextWorkout);
    on<MarkExerciseCompleteEvent>(_markExerciseComplete);
    on<GetWorkoutPlanEvent>(_getWorkoutPlan);
  }

  void _startWorkout(StartWorkoutEvent event, emit) {
    final sessionId = event.sessionId;
    final workoutPlan = FakeDatabase.session_workout_plan
        .where((plan) => plan['session_id'] == sessionId)
        .toList();
    // final session = FakeDatabase.sessions[0];
    late Map<String, Object> exercise;
    print("workout plan: ${workoutPlan}");
    late int index = 0;
    for (var ex in workoutPlan) {
      final id = ex['exercise_id'] as int;
      exercise = FakeDatabase.exercises[id - 1];
      if (ex['complete'] == false) {
        index = ex['exercise_id'] as int;
        break;
      }
    }
    if (index == 0) {
      exercise = FakeDatabase.exercises[0];
    }
    emit(WorkoutInProgress(
        currentExercise: exercise, index: index, sessionId: sessionId));
    // emit(WorkoutComplete());
  }

  void _nextWorkout(NextExerciseEvent event, emit) {
    if (state is WorkoutInProgress) {
      int nextIndex = (state as WorkoutInProgress).index + 1;
      int sessionId = (state as WorkoutInProgress).sessionId;

      final workoutPlan = FakeDatabase.session_workout_plan
          .where((plan) => plan['session_id'] == 1)
          .toList();
      _markExerciseComplete(event, emit);
      if (nextIndex > workoutPlan.length) {
        _markSessionComplete(sessionId);
        emit(WorkoutComplete());
      } else {
        final exercise = FakeDatabase.exercises[nextIndex - 1];

        emit(WorkoutInProgress(
            currentExercise: exercise, index: nextIndex, sessionId: sessionId));
      }
    }
  }

  void _markExerciseComplete(event, emit) {
    if (state is WorkoutInProgress) {
      final index = (state as WorkoutInProgress).index;
      final sessionId = (state as WorkoutInProgress).sessionId;
      final workoutPlan = FakeDatabase.session_workout_plan
          .where((plan) => plan['session_id'] == sessionId)
          .toList();
      final currentExercise = workoutPlan[index - 1];
      currentExercise['complete'] = true;
      emit(ExercisesUpdatedSuccess());
      // emit(WorkoutInProgress(currentExercise: currentExercise, index: index));
    }
    emit(ExercisesUpdatedFailed());
  }

  void _markSessionComplete(int sessionId) {
    final Map<String, Object> session = FakeDatabase.sessions[sessionId - 1];
    session['complete'] = true;
    emit(SessionComplete());
  }

  void _getWorkoutPlan(GetWorkoutPlanEvent event, Emitter<WorkoutState> emit) {
    final workoutPlan = FakeDatabase.session_workout_plan
        .where((plan) => plan['session_id'] == 1)
        .toList();
    emit(SelectedWorkoutPlan(currentWorkoutPlan: workoutPlan));
  }

  void _timer(int index, emit) {
    Future.delayed(Duration(seconds: 10));
    emit();
  }
}
