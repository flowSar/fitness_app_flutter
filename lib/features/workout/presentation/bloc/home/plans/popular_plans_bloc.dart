import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';

abstract class PopularPlansState {}

class PopularPlansInitialState extends PopularPlansState {}

class PopularPlansLoading extends PopularPlansState {
  final List<Map<String, Object>> popularPlans;
  final List<int> plansSessionsIds;
  PopularPlansLoading(
      {required this.popularPlans, required this.plansSessionsIds});
}

abstract class PopularPlansEvent {}

class LoadPopularPlans extends PopularPlansEvent {}

class PlansBloc extends Bloc<PopularPlansEvent, PopularPlansState> {
  PlansBloc() : super(PopularPlansInitialState()) {
    on<LoadPopularPlans>((event, emit) {
      final popularPlans = FakeDatabase.programs;
      final popularPlansIds = FakeDatabase.programs.map((plan) => plan['id']);
      final sessionsIds = FakeDatabase.sessions
          .where((session) => popularPlansIds.contains(session['id'] as int))
          .map((session) => session['id'])
          .toList();

      emit(PopularPlansLoading(
          popularPlans: popularPlans,
          plansSessionsIds: sessionsIds.cast<int>()));
    });
  }
}
