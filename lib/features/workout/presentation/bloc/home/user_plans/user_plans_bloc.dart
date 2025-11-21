import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:w_allfit/core/services/database/FakeDatabase.dart';

abstract class UserPlansState {}

class PopularPlansInitialState extends UserPlansState {}

class UserPlansLoading extends UserPlansState {
  final List<Map<String, Object>> userPlans;
  UserPlansLoading({required this.userPlans});
}

abstract class UserPlansEvent {}

class LoadUserPlans extends UserPlansEvent {}

class UserPlansBloc extends Bloc<UserPlansEvent, UserPlansState> {
  UserPlansBloc() : super(PopularPlansInitialState()) {
    on<LoadUserPlans>((event, emit) {
      final userPlans = FakeDatabase.user_programs;
      emit(UserPlansLoading(userPlans: userPlans));
    });
  }
}
