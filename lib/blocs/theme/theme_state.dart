part of 'theme_bloc.dart';

@immutable
abstract class ThemeState {
  final ThemeData themeData;
  const ThemeState({required this.themeData});
}


class LightTheme extends ThemeState {
  LightTheme() : super(themeData: lightTheme);
}

class DarkTheme extends ThemeState {
  DarkTheme() : super(themeData: darkTheme);
}
