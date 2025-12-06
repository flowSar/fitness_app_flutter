import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';
import 'package:w_allfit/features/workout/domain/usecases/get_user_plan_session_exercises.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session_plan/workout_session_plan_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/workout_session_plan/workout_session_plan_state.dart';

// bloc

class WorkoutSessionPlanBloc
    extends Bloc<SessionWorkoutPlanEvent, SessionWorkoutPlanState> {
  final GetUserPlanSessionExercises getUserPlanSessionExercises;
  WorkoutSessionPlanBloc({required this.getUserPlanSessionExercises})
      : super(WorkoutSessionPlanInitialState()) {
    on<LoadSessionWorkoutPlan>(_loadWorkoutSessionPlan);
  }

  void _loadWorkoutSessionPlan(LoadSessionWorkoutPlan event, emit) async {
    emit(SessionWorkoutPlanLoading());
    final String sessionId = event.sessionId;
    final String? token = await hasToken();
    if (token == null) {
      emit(SessionWorkoutPlanLoadingFailed(error: 'token is missing'));
    }
    final result = await getUserPlanSessionExercises(token!, sessionId);
    if (!result.isSuccess || result.data == null) {
      emit(SessionWorkoutPlanLoadingFailed(error: '${result.error}'));
    }
    final workoutPlan = result.data
        ?.map((elem) => SessionExerciseModel.fromEntity(elem!))
        .toList();
    emit(SessionWorkoutPlanLoaded(workoutPlan: workoutPlan!));
  }
}
