import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/nav_bar.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Egypt Tourist Guide',
      theme: _isDarkMode
          ? ThemeData.dark().copyWith(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Colors.teal.shade900),
            )
          : ThemeData(
              colorScheme:
                  ColorScheme.fromSeed(seedColor: Colors.teal.shade900),
              useMaterial3: true,
            ),
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Egypt Tourist Guide'),
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.dark_mode : Icons.light_mode),
              onPressed: _toggleTheme,
            ),
          ],
        ),
        body: const MyNavigationBar(),
      ),
    );
  }
}
