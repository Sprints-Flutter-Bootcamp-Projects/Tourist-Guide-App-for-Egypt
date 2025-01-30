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
  final APIUser user;

  SignupRequested(this.user);
}

// Firebase events

class FirebaseSignUpRequested extends AuthEvent {
  final FirebaseUser user;

  FirebaseSignUpRequested(this.user);
}

class FirebaseLoginRequested extends AuthEvent {
  final String userEmail;
  final String userPassword;

  FirebaseLoginRequested(this.userEmail, this.userPassword);
}
