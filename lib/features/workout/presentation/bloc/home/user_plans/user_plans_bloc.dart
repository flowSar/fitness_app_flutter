import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/workout/data/models/user_plan_model.dart';
import 'package:w_allfit/features/workout/domain/usecases/add_user_plan_usecase.dart';
import 'package:w_allfit/features/workout/domain/usecases/user_plans_usecase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plan_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plan_state.dart';

class UserPlansBloc extends Bloc<UserPlansEvent, UserPlansState> {
  final UserPlansUsecase userPlansUsecase;
  final AddUserPlanUsecase addUserPlanUsecase;
  UserPlansBloc(
      {required this.userPlansUsecase, required this.addUserPlanUsecase})
      : super(UserPlansInitialState()) {
    on<LoadUserPlans>(_loadUserPlans);
    on<AddUserPlanEvent>(_addUserPlan);
  }

  void _loadUserPlans(event, emit) async {
    emit(UserPlansLoading());
    final token = await hasToken();
    if (token == null) {
      emit(UserPlansLoadingFailed(error: 'token missing'));
    } else {
      final result = await userPlansUsecase(token);
      if (!result.isSuccess || result.data == null) {
        emit(UserPlansLoadingFailed(error: '${result.error}'));
      }
      emit(
        UserPlansLoaded(
          userPlans: result.data!
              .map((item) => UserPlanModel.fromEntity(item))
              .toList(),
        ),
      );
    }
  }

  void _addUserPlan(AddUserPlanEvent event, emit) async {
    emit(UserPlanAdding());
    final String? token = await hasToken();
    final String planId = event.planId;
    if (token == null) {
      emit(UserPlanAddedFailure('token is missing'));
    }

    final result = await addUserPlanUsecase(token!, planId);

    if (!result.isSuccess && result.data == null) {
      emit(UserPlanAddedFailure('${result.error}'));
    } else {
      emit(UserPlanAddedSuccess());
    }
  }
}
