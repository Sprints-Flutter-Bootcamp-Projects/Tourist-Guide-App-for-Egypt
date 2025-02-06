import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/blocs/authentication/auth_bloc.dart';
import 'package:tourist_guide/blocs/places/places_bloc.dart';
import 'package:tourist_guide/blocs/profile/profile_bloc.dart';
import 'package:tourist_guide/blocs/theme/theme_bloc.dart';
import 'package:tourist_guide/controllers/places_controller.dart';
import 'package:tourist_guide/google_maps_test.dart';
import 'package:tourist_guide/landing_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
          ),
          BlocProvider<AuthBloc>(
            create: (context) => AuthBloc(),
          ),
          BlocProvider<ProfileBloc>(
              create: (context) =>
                  ProfileBloc()..add(LoadProfile(allowCache: true)))
        ],
        child: const MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Egypt Tourist Guide',
          theme: state.themeData,
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: context.locale,
          // home: const MyNavigationBar(),
          home: GoogleMapWidget(latitude: 29.9773, longitude: 31.1325),
        );
      }),
    );
  }
}
