import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/data/models/exercise_model.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/user_workout/domain/usecases/get_all_exercises_usecase.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/exercises/exercises_event.dart';
import 'package:w_allfit/features/user_workout/presentation/bloc/exercises/exercises_state.dart';

class ExercisesBloc extends Bloc<ExercisesEvent, ExercisesState> {
  final GetAllExercisesUsecase getAllExercisesUsecase;
  ExercisesBloc({required this.getAllExercisesUsecase})
      : super(ExercisesInitiaState()) {
    on<LoadAllExercises>(_loadAllExercises);
  }

  void _loadAllExercises(LoadAllExercises evvent, emit) async {
    emit(ExercisesLaoding());
    final String? token = await hasToken();

    if (token == null) {
      emit(ExercisesLaodingFailed(error: 'token is missing'));
    }

    final result = await getAllExercisesUsecase(token!);
    if (!result.isSuccess) {
      emit(ExercisesLaodingFailed(error: result.error.toString()));
    }
    final exercises = result.data
            ?.map((exercise) => ExerciseModel.fromEntity(exercise))
            .toList() ??
        [];
    emit(ExercisesLoaded(exercises: exercises));
  }
}
