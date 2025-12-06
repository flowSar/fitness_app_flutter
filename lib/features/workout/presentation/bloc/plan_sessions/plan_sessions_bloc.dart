// sessions event
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/workout/data/models/session_model.dart';
import 'package:w_allfit/features/workout/domain/usecases/get_user_plan_sessions.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_slate.dart';

// sessions bloc

class PlanSessionsBloc extends Bloc<PlanSessionsEvent, PlanSessionsState> {
  final GetUserPlanSessions getUserPlanSessions;
  PlanSessionsBloc({required this.getUserPlanSessions})
      : super(PlanSessionsInitialState()) {
    on<LoadPlanSessions>(_loadPlanSessions);
    on<MarkSessionComplete>(_markSessionComplete);
  }

  void _loadPlanSessions(
      LoadPlanSessions event, Emitter<PlanSessionsState> emit) async {
    try {
      emit(PlanSessionsLoading());
      final planId = event.planId;
      final token = await hasToken();
      if (token == null) {
        emit(PlanSessionsLoadingFailed(error: 'token missing'));
      } else {
        final result = await getUserPlanSessions(token, planId);
        if (!result.isSuccess || result.data == null) {
          emit(PlanSessionsLoadingFailed(error: '${result.error}'));
        }

        if (result.data != null) {
          final planSessions = result.data!
              .map((elem) => SessionModel.fromEntity(elem))
              .toList();
          print('session loaded---------------------${planSessions}');
          emit(PlanSessionsLoaded(planSessions: planSessions));
        }
      }
    } catch (e) {
      emit(PlanSessionsLoadingFailed(error: e.toString()));
    }
  }

  void _markSessionComplete(MarkSessionComplete event, emit) {
    final sessions = (state as PlanSessionsLoaded).planSessions;
    final sessionId = event.sessionId;
    // final session =
    //     sessions.where((session) => session['id'] == sessionId).toList()[0];
    // session['complete'] = true;
  }

  void _loadPlanProgress() {}
}
