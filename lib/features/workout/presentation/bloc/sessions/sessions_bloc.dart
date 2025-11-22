// sessions event
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';

abstract class PlanSessionsState {}

class PlanSessionsInitialState extends PlanSessionsState {}

class PlanSessionsLoading extends PlanSessionsInitialState {
  final List<Map<String, Object>> sessions;
  final Map<String, Object> plan;
  PlanSessionsLoading({required this.plan, required this.sessions});
}

class PlanSessionsLoadingFailed extends PlanSessionsInitialState {}

class SessionComplete extends PlanSessionsState {}

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
      LoadPlanSessions event, Emitter<PlanSessionsState> emit) {
    final planId = event.planId;
    final List<Map<String, Object>> sessions = FakeDatabase.sessions
        .where((session) => session['plan_id'] == planId)
        .toList();
    final Map<String, Object> plan = FakeDatabase.user_programs
        .where((plan) => plan['id'] == planId)
        .toList()[0];
    emit(PlanSessionsLoading(plan: plan, sessions: sessions));
  }

  void _markSessionComplete(MarkSessionComplete event, emit) {
    final sessions = (state as PlanSessionsLoading).sessions;
    final sessionId = event.sessionId;
    final session =
        sessions.where((session) => session['id'] == sessionId).toList()[0];
    session['complete'] = true;
  }
}
