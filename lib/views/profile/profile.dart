import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
// import 'package:tourist_guide/nav_bar.dart';
import 'package:tourist_guide/widgets/app_bar.dart';
// import 'package:tourist_guide/views/authentication.dart';

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
      body: const Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.person_rounded,
            size: 150,
            color: Colors.green,
          ),
          Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              "Full Name",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
            ),

          ),
        ],
      ),
    );
  }
}
