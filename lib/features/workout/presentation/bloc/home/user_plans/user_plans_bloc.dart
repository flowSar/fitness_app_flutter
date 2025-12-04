import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';

abstract class UserPlansState {
  List<Map<String, Object>> get userPlans => [];
}

class UserPlansInitialState extends UserPlansState {}

class UserPlanProgressLoaded extends UserPlansState {
  @override
  final List<Map<String, Object>> userPlans;
  final int progress;
  UserPlanProgressLoaded({required this.userPlans, required this.progress});
}

class UserPlansLoading extends UserPlansState {}

class UserPlansLoaded extends UserPlansState {
  final List<Map<String, Object>> userPlans;

  UserPlansLoaded({required this.userPlans});
}

abstract class UserPlansEvent {}

class LoadUserPlans extends UserPlansEvent {}

class LoadUserPlanProgress extends UserPlansEvent {
  final int planId;
  LoadUserPlanProgress({required this.planId});
}

class UserPlansBloc extends Bloc<UserPlansEvent, UserPlansState> {
  UserPlansBloc() : super(UserPlansInitialState()) {
    on<LoadUserPlans>(_loadUserPlans);
    // on<LoadUserPlanProgress>(_loadUserPlanProgress);
  }

  void _loadUserPlans(event, emit) {
    final userPlans = FakeDatabase.user_programs;
    emit(UserPlansLoaded(userPlans: userPlans));
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
