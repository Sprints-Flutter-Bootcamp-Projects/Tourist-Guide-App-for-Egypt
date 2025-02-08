import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/app_drawer.dart';
import 'package:tourist_guide/models/firebase_models/firebase_user.dart';
import 'package:tourist_guide/services/firebase_service_auth.dart';
import 'package:tourist_guide/services/local_auth_api.dart';
import 'package:tourist_guide/utils/widgets/profile_pic.dart';
import 'package:tourist_guide/views/authentication/login_page.dart';
import 'package:tourist_guide/views/users_data/management/edit_user.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseUser? user;
  bool isLoading = true;
  bool isBioAuthed = false;

  bioAuthenticate() async {
    isBioAuthed = await LocalAuthApi.authenticate();
    setState(() {});
  }

  String hashedPassword(String password) {
    return "#" * password.length;
  }

  @override
  void initState() {
    super.initState();
    FirebaseServiceAuth().fetchCurrentUser().then((fetchedUser) {
      setState(() {
        user = fetchedUser;
        isLoading = false;
      });
      if (user != null) {
        bioAuthenticate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.tr("profile")),
        actions: [
          IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
        ],
      ),
      drawer: const AppDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user != null
              ? isBioAuthed
                  ? buildProfileContent()
                  : const Center(
                      child:
                          Text('Scan Finger Print to View your Profile Data'),
                    )
              : noProfileWidget(context),
    );
  }

  Widget buildProfileContent() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            ProfilePic(),
            const SizedBox(height: 10),
            profileRow(
                context.tr("name"), "${user!.firstName} ${user!.lastName}"),
            profileRow(context.tr("email"), user!.email ?? ""),
            profileRow(
                context.tr("password"), hashedPassword(user!.password ?? "")),
          ],
        ),
      ),
    );
  }

  Widget profileRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,
              style: const TextStyle(
                  color: Colors.teal,
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 17)),
        ],
      ),
    );
  }

  Widget noProfileWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.person_rounded, size: 150, color: Colors.teal[900]),
          Text(context.tr("no_profile_desc")),
          const SizedBox(height: 10),
          FilledButton(
            style: FilledButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6))),
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (context) => const LoginPage())),
            child: Text(tr('log_in')),
          ),
        ],
      ),
    );
  }
}
