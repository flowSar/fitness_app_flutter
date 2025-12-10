import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/get_user_plan_session_exercises.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session_plan/user_workout_session_plan_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/user_workout_session_plan/user_workout_session_plan_state.dart';
import 'package:w_allfit/features/workout/data/models/session_exercise_model.dart';

class UserWorkoutSessionPlanBloc
    extends Bloc<UserSessionWorkoutPlanEvent, UserWorkoutSessionPlanState> {
  final GetUserPlanSessionExercises getUserPlanSessionExercises;
  UserWorkoutSessionPlanBloc({required this.getUserPlanSessionExercises})
      : super(UserWorkoutSessionPlanInitialState()) {
    on<LoadUserSessionWorkoutPlan>(_loadWorkoutSessionPlan);
  }

  void _loadWorkoutSessionPlan(LoadUserSessionWorkoutPlan event, emit) async {
    emit(UserSessionWorkoutPlanLoading());
    final String sessionId = event.sessionId;
    final String? token = await hasToken();
    if (token == null) {
      emit(UserSessionWorkoutPlanLoadingFailed(error: 'token is missing'));
    }
    final result = await getUserPlanSessionExercises(token!, sessionId);
    if (!result.isSuccess || result.data == null) {
      emit(UserSessionWorkoutPlanLoadingFailed(error: '${result.error}'));
    }
    final workoutPlan = result.data
        ?.map((elem) => SessionExerciseModel.fromEntity(elem))
        .toList();
    emit(UserSessionWorkoutPlanLoaded(workoutPlan: workoutPlan!));
  }
}
