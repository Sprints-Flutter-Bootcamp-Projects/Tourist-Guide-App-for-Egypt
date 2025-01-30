part of 'profile_bloc.dart';

@immutable
abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {
  final bool allowCache;

  LoadProfile({required this.allowCache});
}

class CreateProfile extends ProfileEvent {
  final APIUser user;

  CreateProfile(this.user);
}

class UpdateProfile extends ProfileEvent {
  final APIUser user;

  UpdateProfile(this.user);
}

class DeleteProfile extends ProfileEvent {
  final String userId;

  DeleteProfile(this.userId);
}

class UpdateAvatar extends ProfileEvent {
  final APIUser user;
  final String avatarUrl;

  UpdateAvatar(this.user, this.avatarUrl);
}
