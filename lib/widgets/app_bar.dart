import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/nav_bar.dart';
import 'package:tourist_guide/widgets/lang_dialog.dart';

import '../views/authentication/login_page.dart';
import '../views/profile/edit_profile.dart';

// ignore: non_constant_identifier_names
PreferredSizeWidget? PagesAppBar(BuildContext context, String AppBarTitle) {
  return AppBar(
    iconTheme: IconThemeData(color: Colors.teal[900]),
    backgroundColor: Colors.white,
    shadowColor: Colors.grey[100],
    elevation: 1,
    centerTitle: true,
    title: Text(
      AppBarTitle,
      style: TextStyle(color: Colors.teal[900]),
    ),
    actions: <Widget>[
      IconButton(
        icon: const Icon(Icons.language),
        onPressed: () => langDialog(context),
      ),
    ],
    // leading: selectedPage == 3
    // ? PopupMenuButton(
    // itemBuilder: (context) => <PopupMenuItem>[
    // PopupMenuItem(
    //   child: Text(tr('log_in')),
    //   onTap: () => Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => const LoginPage(),
    //     ),
    //   ),
    // ),
    // PopupMenuItem(
    //   child: Text(tr('edit_profile')),
    //   onTap: () => showModalBottomSheet(
    //     context: context,
    //     isScrollControlled: true,
    //     builder: (context) {
    //       return editProfile();
    //     },
    //   ),
    // )
    // ],
    // )
    // : null,
  );
}
