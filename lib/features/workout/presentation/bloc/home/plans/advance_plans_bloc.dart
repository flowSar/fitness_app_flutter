import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/constants/plansType.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/plans_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/plans_state.dart';

class AdvancePlansBloc extends Bloc<PlansEvent, PlansState> {
  AdvancePlansBloc() : super(PlansInitialState()) {
    on<LoadAdvancePlans>(_loadAdvancePlans);
  }
  void _loadAdvancePlans(LoadAdvancePlans event, emit) {
    emit(PlansLoading(
        planType: PlanBlocType.advanced, plans: [], plansSessionsIds: []));
    final beginnerPlans = FakeDatabase.programs
        .where((plan) => plan['level'] == 'Advance')
        .toList();
    final popularPlansIds = FakeDatabase.programs.map((plan) => plan['id']);
    final sessionsIds = FakeDatabase.sessions
        .where((session) => popularPlansIds.contains(session['id'] as int))
        .map((session) => session['id'])
        .toList();

    emit(PlansLoaded(
        planType: PlanBlocType.advanced,
        plans: beginnerPlans,
        plansSessionsIds: sessionsIds.cast<int>()));
  }
}
