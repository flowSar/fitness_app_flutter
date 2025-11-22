import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/constants/plansType.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/plans_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/plans_state.dart';

class BeginnerPlansBloc extends Bloc<PlansEvent, PlansState> {
  BeginnerPlansBloc() : super(PlansInitialState()) {
    on<LoadBeginnerPlans>(_loadBeginnersPlans);
  }

  void _loadBeginnersPlans(LoadBeginnerPlans event, emit) {
    emit(PlansLoading(
        planType: PlanType.beginner, plans: [], plansSessionsIds: []));
    final beginnerPlans = FakeDatabase.programs
        .where((plan) => plan['level'] == 'beginner')
        .toList();
    final popularPlansIds = FakeDatabase.programs.map((plan) => plan['id']);
    final sessionsIds = FakeDatabase.sessions
        .where((session) => popularPlansIds.contains(session['id'] as int))
        .map((session) => session['id'])
        .toList();

    emit(PlansLoaded(
        planType: PlanType.beginner,
        plans: beginnerPlans,
        plansSessionsIds: sessionsIds.cast<int>()));
  }
}
