import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/blocs/places/places_bloc.dart';
import 'package:tourist_guide/blocs/theme/theme_bloc.dart';
import 'package:tourist_guide/controllers/places_controller.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en', 'US'),
      child: MultiBlocProvider(
        providers: [
          BlocProvider<ThemeBloc>(
            create: (context) => ThemeBloc(),
          ),
          BlocProvider<PlacesBloc>(
            create: (context) => PlacesBloc(PlacesController()),
          )
        ],
        child: const MyApp(),
      ),
    ),
  );
}
