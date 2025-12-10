// event
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';

abstract class QuickStartWorkoutEvent {}

class LoadQuickStartWorkoutPlans extends QuickStartWorkoutEvent {
  final List<PlanModel> workoutPlans;
  LoadQuickStartWorkoutPlans({required this.workoutPlans});
}

//state
abstract class QuickStartWorkoutState {}

class LoadQuickStartWorkoutInitialState extends QuickStartWorkoutState {}

class QuickStartWorkoutLoading extends QuickStartWorkoutState {}

class QuickStartWorkoutLoaded extends QuickStartWorkoutState {
  final List<PlanModel> workoutPlans;
  QuickStartWorkoutLoaded({required this.workoutPlans});
}

class QuickStartWorkoutBloc
    extends Bloc<QuickStartWorkoutEvent, QuickStartWorkoutState> {
  QuickStartWorkoutBloc() : super(LoadQuickStartWorkoutInitialState()) {
    on<LoadQuickStartWorkoutPlans>(_loadWorkoutPlans);
  }

  void _loadWorkoutPlans(LoadQuickStartWorkoutPlans event, emit) {
    final workoutPlans = event.workoutPlans;
    emit(QuickStartWorkoutLoading());

    emit(QuickStartWorkoutLoaded(workoutPlans: workoutPlans));
  }
}
