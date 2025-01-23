// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent{}

class UpdateProfile extends ProfileEvent {
  final User profileUpdate;
  UpdateProfile({
    required this.profileUpdate,
  });
}

class UpdateAvatar extends ProfileEvent {
  final String newAvatar;
  UpdateAvatar({
    required this.newAvatar,
  });
}
