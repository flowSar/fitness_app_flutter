import 'package:w_allfit/features/auth/data/models/user_model.dart';

abstract class AuthEvent {}

class SignUpEvent extends AuthEvent {
  final UserModel user;
  SignUpEvent({required this.user});
}

class LogInEvent extends AuthEvent {
  final String email;
  final String password;
  LogInEvent({required this.email, required this.password});
}

class LogOutEvent extends AuthEvent {}

class CheckAuthState extends AuthEvent {}
