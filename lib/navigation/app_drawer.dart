// filepath: /D:/Sprints/Module 2/Tourist-Guide-App-for-Egypt/lib/widgets/drawer.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/blocs/theme/theme_bloc.dart';
import 'package:tourist_guide/helpers/shared_pref.dart';

import 'package:tourist_guide/views/authentication/login_page.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(
      builder: (context, state) {
          bool isLightTheme = state is LightTheme;
          return NavigationDrawer(
            children: [
              ListTile(
                title: Text(tr("settings")),
                onTap: () {},
              ),
              ListTile(
                title: Text(tr("profile")),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.edit),
                title: Text(tr("edit_profile")),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                title: Text(tr("theme")),
                onTap: () {},
              ),
             ListTile(
              leading: Icon(isLightTheme ? Icons.dark_mode : Icons.light_mode),
              title: Text(isLightTheme ? tr("dark_theme") : tr("light_theme")),
              onTap: () {
                BlocProvider.of<ThemeBloc>(context).add(ToggleTheme());
              },
            ),
              const Divider(),
              ListTile(
                title: Text(tr("language")),
                onTap: () {},
              ),
              ListTile(
                leading: const Icon(Icons.g_translate),
                title: Text(tr("language")),
                onTap: () {},
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.logout),
                title: Text(tr("log_out")),
                onTap: () {
                  SharedPreferencesHelper.clearUserData();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginPage(),
                    ),
                  );
                },
              ),
            ],
          );
        }
      
      
    );
  }
}
