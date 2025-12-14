// sessions event
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/get_user_plan_sessions.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/plan_sessions/user_plan_sessions_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/plan_sessions/user_plan_sessions_state.dart';
import 'package:w_allfit/features/workout/data/models/session_model.dart';

class UserPlanSessionsBloc
    extends Bloc<UserPlanSessionsEvent, UserPlanSessionsState> {
  final GetUserPlanSessions getUserPlanSessions;
  UserPlanSessionsBloc({required this.getUserPlanSessions})
      : super(UserPlanSessionsInitialState()) {
    on<LoadUserPlanSessions>(_loadPlanSessions);
  }

  void _loadPlanSessions(
      LoadUserPlanSessions event, Emitter<UserPlanSessionsState> emit) async {
    try {
      emit(UserPlanSessionsLoading());
      final planId = event.planId;
      final token = await hasToken();
      if (token == null) {
        emit(UserPlanSessionsLoadingFailed(error: 'token missing'));
      } else {
        final result = await getUserPlanSessions(token, planId);
        if (!result.isSuccess || result.data == null) {
          emit(UserPlanSessionsLoadingFailed(error: '${result.error}'));
        }

        if (result.data != null) {
          final planSessions = result.data!
              .map((elem) => SessionModel.fromEntity(elem))
              .toList();
          print('session loaded---------------------$planSessions');
          emit(UserPlanSessionsLoaded(planSessions: planSessions));
        }
      }
    } catch (e) {
      emit(UserPlanSessionsLoadingFailed(error: e.toString()));
    }
  }
}
