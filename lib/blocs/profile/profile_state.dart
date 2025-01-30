part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final List<APIUser> users;

  ProfileLoaded(this.users);
}

class ProfileError extends ProfileState {
  final String errorMsg;

  ProfileError(this.errorMsg);
}
