// event
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';

abstract class QuickStartWorkoutEvent {}

class LoadQuickStartWorkoutPlans extends QuickStartWorkoutEvent {
  LoadQuickStartWorkoutPlans();
}

class LoadQuickStartWorkout extends QuickStartWorkoutEvent {
  final int quickStartPlanId;
  LoadQuickStartWorkout({required this.quickStartPlanId});
}

//state
abstract class QuickStartWorkoutState {}

class LoadQuickStartWorkoutInitialState extends QuickStartWorkoutState {}

class QuickStartWorkoutLoading extends QuickStartWorkoutState {
  final List<Map<String, Object>> quickStartWorkoutPlans;
  final List<int> sessionsIds;
  QuickStartWorkoutLoading(
      {required this.quickStartWorkoutPlans, required this.sessionsIds});
}

class QuickStartWorkoutBloc
    extends Bloc<QuickStartWorkoutEvent, QuickStartWorkoutState> {
  QuickStartWorkoutBloc() : super(LoadQuickStartWorkoutInitialState()) {
    on<LoadQuickStartWorkoutPlans>(_loadQuickStartWorkouts);
  }

  void _loadQuickStartWorkouts(event, emit) {
    final quickStartWorkoutIds =
        FakeDatabase.quickStartWorkout.map((item) => item['plan_id']).toList();

    final quickStartWorkoutPlans = FakeDatabase.programs
        .where((plan) => quickStartWorkoutIds.contains(plan['id'] as int))
        .toList();

    // get sessions ids of all quick start plans
    final sessionsIds = FakeDatabase.sessions
        .where((session) =>
            quickStartWorkoutIds.contains(session['plan_id'] as int))
        .map((item) => item['id'])
        .toList();

    emit(QuickStartWorkoutLoading(
        sessionsIds: sessionsIds.cast<int>(),
        quickStartWorkoutPlans: quickStartWorkoutPlans));
  }

  void _loadQuickStartWorkoutPlan(LoadQuickStartWorkout event, emit) {
    final int quickStartPlanId = event.quickStartPlanId;
    final quickStartPLan = FakeDatabase.quickStartWorkout
        .where((plan) => plan['id'] == quickStartPlanId)
        .toList()[0];
    final int planId = quickStartPLan['plan_id'] as int;
    final plan = FakeDatabase.programs
        .where((program) => program['id'] == planId)
        .toList()[0];
    final session = FakeDatabase.sessions
        .where((session) => session['plan_id'] == plan['id'])
        .toList()[0];

    final exercisesPlan = FakeDatabase.session_workout_plan
        .where((sessionPlan) => sessionPlan['session_id'] == session['id'])
        .toList();

    // emit(LoadQuickStartWorkoutLoading(quickStartWorkoutPlans: exercisesPlan));
  }
}
