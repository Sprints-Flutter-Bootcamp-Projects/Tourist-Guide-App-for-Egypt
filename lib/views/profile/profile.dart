import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/nav_bar.dart';
import 'package:tourist_guide/widgets/app_bar.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesAppBar(context, context.tr("profile")),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.person_2_outlined,
            size: 200,
          ),
          Text(
            isLoggedIn ? "User Name" : 'Logged in as a Guest',
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
