import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/utils/constants/theme_data.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightTheme()) {
    on<ToggleTheme>((event, emit) {
      if (state is LightTheme) {
        emit(DarkTheme());
      } else {
        emit(LightTheme());
      }
    });
  }
}
