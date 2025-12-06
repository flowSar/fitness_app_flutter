import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/shared_preferences/shared_preference.dart';
import 'package:w_allfit/features/workout/data/models/plan_model.dart';
import 'package:w_allfit/features/workout/domain/usecases/user_plans_usecase.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plan_event.dart';
import 'package:w_allfit/features/workout/presentation/bloc/home/user_plans/user_plan_state.dart';

class UserPlansBloc extends Bloc<UserPlansEvent, UserPlansState> {
  final UserPlansUsecase userPlansUsecase;
  UserPlansBloc({required this.userPlansUsecase})
      : super(UserPlansInitialState()) {
    on<LoadUserPlans>(_loadUserPlans);
    // on<LoadUserPlanProgress>(_loadUserPlanProgress);
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
          userPlans:
              result.data!.map((item) => PlanModel.fromEntity(item)).toList(),
        ),
      );
    }
  }

  // void _loadUserPlanProgress(LoadUserPlanProgress event, emit) {
  //   final int planId = event.planId;
  //
  //   final List<Map<String, Object>> planSessions = FakeDatabase.sessions
  //       .where((session) => session['plan_id'] == planId)
  //       .toList();
  //   print('-----sessions--------${planSessions}');
  //   late int complete = 0;
  //   for (final session in planSessions) {
  //     if (session['complete'] as bool == true) {
  //       complete++;
  //     }
  //   }
  //   late int progress = (complete / planSessions.length).round();
  //   final userPlans = FakeDatabase.user_programs;
  //   emit(UserPlanProgressLoaded(userPlans: userPlans, progress: progress));
  // }
}
