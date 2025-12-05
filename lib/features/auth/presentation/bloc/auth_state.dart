import 'package:w_allfit/features/auth/data/models/user_model.dart';

abstract class AuthState {}

class AuthInitialeState extends AuthState {}

// sign up

class SignUpSucess extends AuthState {
  final UserModel user;

  SignUpSucess({required this.user});
}

class SignUpFailed extends AuthState {
  final String error;

  SignUpFailed({required this.error});
}

class SignUpLoading extends AuthState {}

// log in
class LoginSucess extends AuthState {
  final UserModel? user;
  final String token;

  LoginSucess({this.user, required this.token});
}

class LoginFailed extends AuthState {
  final String error;

  LoginFailed({required this.error});
}

class LoginLoading extends AuthState {}

// authenticated

class Authenticated extends AuthState {
  final UserModel? user;
  final bool isAuthenticated;

  Authenticated({this.user, required this.isAuthenticated});
}

class AuthFailed extends AuthState {
  final String error;

  AuthFailed({required this.error});
}

// log out

class LogOutLoding extends AuthState {}

class LogOutSuccess extends AuthState {}

class LogOutFailed extends AuthState {
  final String error;

  LogOutFailed({required this.error});
}
