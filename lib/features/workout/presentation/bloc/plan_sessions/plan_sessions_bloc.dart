// sessions event
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/plan_sessions/plan_sessions_slate.dart';

// sessions event
abstract class SessionsEvent {}

class LoadPlanSessions extends SessionsEvent {
  final int planId;
  LoadPlanSessions({required this.planId});
}

class MarkSessionComplete extends SessionsEvent {
  final int sessionId;
  MarkSessionComplete({required this.sessionId});
}

// sessions bloc

class PlanSessionsBloc extends Bloc<SessionsEvent, PlanSessionsState> {
  PlanSessionsBloc() : super(PlanSessionsInitialState()) {
    on<LoadPlanSessions>(_loadPlanSessions);
    on<MarkSessionComplete>(_markSessionComplete);
  }

  void _loadPlanSessions(
      LoadPlanSessions event, Emitter<PlanSessionsState> emit) async {
    try {
      emit(PlanSessionsLoading());
      final planId = event.planId;
      final List<Map<String, Object>> sessions = FakeDatabase.sessions
          .where((session) => session['plan_id'] == planId)
          .toList();

      final Map<String, Object> plan = FakeDatabase.user_programs
          .where((plan) => plan['id'] == planId)
          .toList()[0];
      await Future.delayed(Duration(seconds: 1));
      emit(PlanSessionsLoaded(plan: plan, planSessions: sessions));
    } catch (e) {
      emit(PlanSessionsLoadingFailed(error: e.toString()));
    }
  }

  void _markSessionComplete(MarkSessionComplete event, emit) {
    final sessions = (state as PlanSessionsLoaded).planSessions;
    final sessionId = event.sessionId;
    final session =
        sessions.where((session) => session['id'] == sessionId).toList()[0];
    session['complete'] = true;
  }

  void _loadPlanProgress() {}
}
