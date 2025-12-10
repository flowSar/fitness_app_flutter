import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/features/explore/data/models/plan_model.dart';
import 'package:w_allfit/features/explore/domain/usecases/get_all_workout_plans_usecase.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_event.dart';
import 'package:w_allfit/features/explore/presentation/bloc/workout_plans_state.dart';

class WorkoutPlansBloc extends Bloc<WorkoutPlansEvent, WorkoutPlansState> {
  final GetAllWorkoutPlansUsecase getAllWorkoutPlansUsecase;
  WorkoutPlansBloc({required this.getAllWorkoutPlansUsecase})
      : super(WorkoutPlansInitialState()) {
    on<LoadWorkoutPlans>(_loadWorkoutPlans);
  }

  void _loadWorkoutPlans(LoadWorkoutPlans event, emit) async {
    emit(WorkoutPlansLoading());

    final result = await getAllWorkoutPlansUsecase('type=multi_session');
    final result2 = await getAllWorkoutPlansUsecase('type=single_session');
    if (!result.isSuccess || result2.isSuccess) {
      emit(WorkoutPlansLoadingfailed(error: '${result.error}'));
    }
    final workoutPrograms =
        result.data?.map((plan) => PlanModel.fromEntity(plan)).toList();
    final workoutPlans =
        result2.data?.map((plan) => PlanModel.fromEntity(plan)).toList();

    emit(WorkoutPlansLoaded(
        workoutPrograms: workoutPrograms!, workoutPlans: workoutPlans!));
  }
}
