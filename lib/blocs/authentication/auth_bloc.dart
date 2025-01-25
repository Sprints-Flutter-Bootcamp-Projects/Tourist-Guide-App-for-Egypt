import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/helpers/shared_pref.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(checkUser);

    on<LogoutRequested>((event, emit) => emit(AuthUnauthenticated()));

    on<SignupRequested>(signUp);
  }

  void checkUser(LoginRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      var userData = await SharedPreferencesHelper.getUserData();
      if (userData != null &&
          event.userEmail == userData['email'] &&
          event.userPassword == userData['password']) {
        emit(AuthAuthenticated(userData));
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
      var userData = await SharedPreferencesHelper.getUserData();
      if (userData != null && event.userData['email'] == userData['email']) {
        emit(AuthAuthenticated(userData));
      } else {
        emit(AuthUnauthenticated());
        await SharedPreferencesHelper.saveUserData(event.userData);
      }
    } on Exception catch (e) {
      AuthError(e.toString());
    }
  }
}
