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

// sessions event
abstract class SessionsEvent {}

class LoadPlanSessions extends SessionsEvent {
  final int planId;
  LoadPlanSessions({required this.planId});
}
// sessions bloc

class PlanSessionsBloc extends Bloc<SessionsEvent, PlanSessionsState> {
  PlanSessionsBloc() : super(PlanSessionsInitialState()) {
    on<LoadPlanSessions>(
        (LoadPlanSessions event, Emitter<PlanSessionsState> emit) {
      final planId = event.planId;
      final List<Map<String, Object>> sessions = FakeDatabase.sessions
          .where((session) => session['plan_id'] == planId)
          .toList();
      final Map<String, Object> plan = FakeDatabase.user_programs
          .where((plan) => plan['id'] == planId)
          .toList()[0];
      emit(PlanSessionsLoading(plan: plan, sessions: sessions));
    });
  }
}
