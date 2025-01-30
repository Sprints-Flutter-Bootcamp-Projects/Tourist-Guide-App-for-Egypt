import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/models/user.dart';
import 'package:tourist_guide/services/api_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(checkUser);

    on<LogoutRequested>((event, emit) => emit(AuthUnauthenticated()));

    on<SignupRequested>(signUp);
  }

  final ApiService apiService = ApiService();

  void checkUser(LoginRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final users = await apiService.getUsers(allowCache: true);
      //returning the user index if it exists and if not then -1 is returned
      final index = users.indexWhere(
        (user) =>
            event.userEmail == user.email &&
            event.userPassword == user.password,
      );
      if (index != -1) {
        emit(AuthAuthenticated(users[index]));
      } else {
        emit(AuthUnauthenticated());
      }
    } on Exception catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> signUp(SignupRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final users = await apiService.getUsers(allowCache: true);
      final index = users.indexWhere((user) => event.user.email == user.email);
      if (index != -1) {
        emit(AuthAuthenticated(users[index]));
      } else {
        emit(AuthUnauthenticated());
        await apiService.createUser(event.user);
      }
    } on Exception catch (e) {
      AuthError(e.toString());
    }
  }
}
