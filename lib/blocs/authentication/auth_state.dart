part of 'auth_bloc.dart';

@immutable
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthAuthenticated extends AuthState {
  final FirebaseUser user;
  AuthAuthenticated(this.user);
  // AuthAuthenticated();
}

class AuthUnauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String errorMsg;

  AuthError(this.errorMsg);
}
