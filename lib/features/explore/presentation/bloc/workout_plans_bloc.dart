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

    final result = await getAllWorkoutPlansUsecase();
    if (!result.isSuccess) {
      emit(WorkoutPlansLoadingfailed(error: '${result.error}'));
    }
    final workoutPlans =
        result.data?.map((plan) => PlanModel.fromEntity(plan)).toList();

    emit(WorkoutPlansLoaded(workoutPlans: workoutPlans!));
  }
}
