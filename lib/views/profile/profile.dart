import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tourist_guide/blocs/authentication/auth_bloc.dart';
import 'package:tourist_guide/app_drawer.dart';
import 'package:tourist_guide/models/firebase_models/firebase_user.dart';
import 'package:tourist_guide/views/authentication/login_page.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseUser? user; // Nullable to handle loading state
  bool isLoading = true;

  String hashedPassword(String password) {
    return "#" * password.length; // More concise hashing
  }

  Future<void> getUserData(String uid) async {
    final db = FirebaseFirestore.instance;
    try {
      final doc = await db.collection("users").doc(uid).get();
      if (doc.exists) {
        setState(() {
          user = FirebaseUser.fromFirestore(doc);
          isLoading = false;
        });
      } else {
        setState(() => isLoading = false);
      }
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() => isLoading = false);
    }
  }

  @override
  void initState() {
    super.initState();
    final authState = context.read<AuthBloc>().state;
    if (authState is AuthAuthenticated) {
      getUserData(authState.user.id!); // Fetch user data if authenticated
    } else {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.tr("profile"))),
      drawer: const AppDrawer(),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : user != null
              ? Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(user!.avatar ?? ""),
                            radius: 70,
                          ),
                        ),
                        profileRow(context.tr("name"),
                            "${user!.firstName} ${user!.lastName}"),
                        profileRow(context.tr("email"), user!.email ?? ""),
                        profileRow(context.tr("password"),
                            hashedPassword(user!.password ?? "")),
                      ],
                    ),
                  ),
                )
              : noProfileWidget(context),
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
