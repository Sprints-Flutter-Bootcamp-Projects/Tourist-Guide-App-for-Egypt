// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

@immutable
abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState{
  
}

class ProfileLoaded extends ProfileState {
  List<User> userData;
  ProfileLoaded({
    required this.userData,
  });
}

class ProfileUpdate extends ProfileState{}

class ProfileError extends ProfileState {
  final String error;
  ProfileError({
    required this.error,
  });
}
