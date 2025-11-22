import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';

abstract class SessionWorkoutPlanEvent {}

class LoadSessionWorkoutPlan extends SessionWorkoutPlanEvent {
  final int planId;
  final int sessionId;
  LoadSessionWorkoutPlan({required this.planId, required this.sessionId});
}

abstract class SessionWorkoutPlanState {}

class WorkoutSessionPlanInitialState extends SessionWorkoutPlanState {}

class SessionWorkoutPlanLoading extends SessionWorkoutPlanState {
  final Map<String, Object> plan;
  final List<Map<String, Object>> workoutPlan;
  SessionWorkoutPlanLoading({required this.plan, required this.workoutPlan});
}

// bloc

class SessionWorkoutPlanBloc
    extends Bloc<SessionWorkoutPlanEvent, SessionWorkoutPlanState> {
  SessionWorkoutPlanBloc() : super(WorkoutSessionPlanInitialState()) {
    on<LoadSessionWorkoutPlan>(_loadWorkoutSessionPlan);
  }

  void _loadWorkoutSessionPlan(LoadSessionWorkoutPlan event, emit) {
    final int sessionId = event.sessionId;
    final int planId = event.planId;

    final plan =
        FakeDatabase.programs.where((plan) => plan['id'] == planId).toList()[0];

    final workoutPlan = FakeDatabase.session_workout_plan
        .where((workoutPlan) => workoutPlan['session_id'] == sessionId)
        .toList();

    emit(SessionWorkoutPlanLoading(plan: plan, workoutPlan: workoutPlan));
  }

  // void _loadQuickStartWorkoutPlan() {
  //   final int planId = 1;
  //   final plan = FakeDatabase.quickStartWorkout
  //       .where((plan) => plan['id'] == planId)
  //       .toList()[0];
  //   final workoutPlan = FakeDatabase.quickStartWorkoutPlan;
  //   emit(SessionWorkoutPlanLoading(plan: plan, workoutPlan: workoutPlan));
  // }
}
