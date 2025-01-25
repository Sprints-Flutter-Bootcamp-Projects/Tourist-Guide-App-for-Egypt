import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/helpers/shared_pref.dart';
import 'package:tourist_guide/models/user.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial());

  @override
  Stream<ProfileState> mapEventToState(
    ProfileEvent event,
  ) async* {
    if (event is LoadProfile) {
      ProfileLoading();
      try {
        final profileData =
            await SharedPreferencesHelper.getUserData() as List<User>;
        ProfileLoaded(userData: profileData);
      } catch (e) {
        ProfileError(error: e.toString());
      }
    } else if (event is UpdateProfile) {
      ProfileLoading();
      try {
        ProfileUpdate();
      } catch (e) {
        ProfileError(error: e.toString());
      }
    } else if (event is UpdateAvatar) {
      ProfileLoading();
      try {
        ProfileUpdate();
      } catch (e) {
        ProfileError(error: e.toString());
      }
    }
  }
}
