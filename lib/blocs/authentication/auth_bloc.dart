import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/models/firebase_models/firebase_user.dart';
import 'package:tourist_guide/models/user.dart';
import 'package:tourist_guide/services/api_service.dart';
import 'package:tourist_guide/services/firebase_service_auth.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LogoutRequested>((event, emit) => emit(AuthUnauthenticated()));

    // on<LoginRequested>(checkUser);
    // on<SignupRequested>(signUp);

    // on Firebase events
    on<FirebaseSignUpRequested>(firebaseSignUp);
    on<FirebaseLoginRequested>(firebaseLogin);
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
        // emit(AuthAuthenticated(users[index]));
        // emit(AuthAuthenticated(users));
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
        // emit(AuthAuthenticated(users[index]));
        // emit(AuthAuthenticated());
      } else {
        emit(AuthUnauthenticated());
        await apiService.createUser(event.user);
      }
    } on Exception catch (e) {
      AuthError(e.toString());
    }
  }

  // Firebase actions

  Future<void> firebaseSignUp(
      FirebaseSignUpRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final user = await FirebaseServiceAuth().firebaseSignUp(
        firstName: event.user.firstName!,
        lastName: event.user.lastName!,
        phone: event.user.phone!,
        email: event.user.email!,
        password: event.user.password!,
      );
      if (user != null) {
        print(user);
        emit(AuthAuthenticated(user));
      }
    } on Exception catch (e) {
      AuthError(e.toString());
    }
  }

  Future<void> firebaseLogin(
      FirebaseLoginRequested event, Emitter<AuthState> emit) async {
    try {
      emit(AuthLoading());
      final user = await FirebaseServiceAuth().firebaseSignIn(
        email: event.userEmail,
        password: event.userPassword,
      );

      if (user != null) {
        emit(AuthAuthenticated(user));
      } else {
        emit(AuthUnauthenticated());
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;
      switch (e.code) {
        case 'user-not-found':
          errorMessage = tr('user_not_found');
          break;
        case 'wrong-password':
          errorMessage = tr('wrong_password');
          break;
        default:
          errorMessage = e.message ?? tr('unknown_error');
      }
      print("------------> Firebase error: $errorMessage");
      emit(AuthError(errorMessage));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }
}
