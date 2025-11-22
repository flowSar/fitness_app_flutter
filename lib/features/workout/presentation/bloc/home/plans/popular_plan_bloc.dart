import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/constants/plansType.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/plans_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/plans/plans_state.dart';

class PopularPlansBloc extends Bloc<PlansEvent, PlansState> {
  PopularPlansBloc() : super(PlansInitialState()) {
    on<LoadPopularPlans>(_loadPopularPlans);
  }

  void _loadPopularPlans(LoadPopularPlans event, emit) {
    emit(PlansLoading(
        planType: PlanType.popular, plans: [], plansSessionsIds: []));
    final beginnerPlans = FakeDatabase.programs;
    final popularPlansIds = FakeDatabase.programs.map((plan) => plan['id']);
    final sessionsIds = FakeDatabase.sessions
        .where((session) => popularPlansIds.contains(session['id'] as int))
        .map((session) => session['id'])
        .toList();

    emit(PlansLoaded(
        planType: PlanType.popular,
        plans: beginnerPlans,
        plansSessionsIds: sessionsIds.cast<int>()));
  }
}
