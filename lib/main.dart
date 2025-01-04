import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

import 'my_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}
