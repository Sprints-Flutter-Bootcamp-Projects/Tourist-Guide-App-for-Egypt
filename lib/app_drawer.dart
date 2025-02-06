// filepath: /D:/Sprints/Module 2/Tourist-Guide-App-for-Egypt/lib/widgets/drawer.dart
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/blocs/authentication/auth_bloc.dart';
import 'package:tourist_guide/blocs/theme/theme_bloc.dart';
import 'package:tourist_guide/services/firebase_service_auth.dart';
import 'package:tourist_guide/views/users_data/management/edit_user.dart';
import 'package:tourist_guide/views/users_data/users_list.dart';
import 'package:tourist_guide/utils/widgets/lang_dialog.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeBloc, ThemeState>(builder: (context, state) {
      bool isLightTheme = state is LightTheme;
      return NavigationDrawer(
        children: [
          ListTile(
            title: Text(tr("settings"),
                style:
                    const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            onTap: () {},
          ),
          // will probably have to remove this and move it to the profile page
          ListTile(
            title: Text(tr("profile")),
            onTap: () {},
          ),
          ListTile(
            leading: const Icon(Icons.edit),
            title: Text(tr("users_profiles")),
            onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const UserListPage(),
                )),
          ),

          // ------------------------------------------------------------------
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
            onTap: () {
              langDialog(context);
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout),
            title: Text(tr("log_out")),
            onTap: () {
              context.read<AuthBloc>().add(LogoutRequested());
              FirebaseServiceAuth().firebaseLogout();
              Navigator.pop(context);
            },
          ),
        ],
      );
    });
  }
}
