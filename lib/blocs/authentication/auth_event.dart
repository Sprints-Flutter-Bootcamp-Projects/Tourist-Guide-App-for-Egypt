part of 'auth_bloc.dart';

@immutable
abstract class AuthEvent {}

class LoginRequested extends AuthEvent {
  final String userEmail;
  final String userPassword;

  LoginRequested(this.userEmail, this.userPassword);
}

class LogoutRequested extends AuthEvent {}

class SignupRequested extends AuthEvent {
  final User user;

  SignupRequested(this.user);
}
