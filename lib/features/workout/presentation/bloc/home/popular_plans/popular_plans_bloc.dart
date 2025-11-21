import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';

abstract class PopularPlansState {}

class PopularPlansInitialState extends PopularPlansState {}

class PopularPlansLoading extends PopularPlansState {
  final List<Map<String, Object>> popularPlans;
  PopularPlansLoading({required this.popularPlans});
}

abstract class PopularPlansEvent {}

class LoadPopularPlans extends PopularPlansEvent {}

class PopularPlansBloc extends Bloc<PopularPlansEvent, PopularPlansState> {
  PopularPlansBloc() : super(PopularPlansInitialState()) {
    on<LoadPopularPlans>((event, emit) {
      final popularPlans = FakeDatabase.programs;
      emit(PopularPlansLoading(popularPlans: popularPlans));
    });
  }
}
