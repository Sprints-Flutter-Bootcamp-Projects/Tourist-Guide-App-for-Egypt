import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/models/user.dart';
import 'package:tourist_guide/services/api_service.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>(loadUsers);

    on<UpdateProfile>(updateUser);

    on<CreateProfile>(createUser);

    on<DeleteProfile>(deleteUser);

    on<UpdateAvatar>(updateUserAvatar);
  }

  final ApiService apiService = ApiService();

  Future<void> loadUsers(LoadProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      final users = await apiService.getUsers(allowCache: event.allowCache);
      emit(ProfileLoaded(users));
    } catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> createUser(
      CreateProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      await apiService.createUser(event.user);
      final users = await apiService.getUsers(allowCache: true);
      emit(ProfileLoaded(users));
    } on Exception catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateUser(
      UpdateProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      await apiService.updateUser(event.user);
      final users = await apiService.getUsers(allowCache: true);
      emit(ProfileLoaded(users));
    } on Exception catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> updateUserAvatar(
      UpdateAvatar event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      await apiService.updateUserAvatar(event.user, event.avatarUrl);
      final users = await apiService.getUsers(allowCache: true);
      emit(ProfileLoaded(users));
    } on Exception catch (e) {
      emit(ProfileError(e.toString()));
    }
  }

  Future<void> deleteUser(
      DeleteProfile event, Emitter<ProfileState> emit) async {
    try {
      emit(ProfileLoading());
      await apiService.deleteUser(event.userId);
      final users = await apiService.getUsers(allowCache: true);
      emit(ProfileLoaded(users));
    } on Exception catch (e) {
      emit(ProfileError(e.toString()));
    }
  }
}
