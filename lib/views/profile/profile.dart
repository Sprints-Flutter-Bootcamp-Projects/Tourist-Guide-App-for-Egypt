import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/views/authentication/login_page.dart';
import 'package:tourist_guide/widgets/app_bar.dart';

import '../../helpers/shared_pref.dart';

class Profile extends StatefulWidget {
  final String name;
  final String email;
  final String password;

  const Profile({
    super.key,
    required this.name,
    required this.email,
    required this.password,
  });

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isUser = false;
  Map<String, dynamic>? userData;
  void checkUser() async {
    userData = await SharedPreferencesHelper.getUserData();
    if (userData != null) {
      print('Profile User data: $userData');
      isUser = true;
    } else {
      print("No user data found.");
      isUser = false;
    }
    setState(() {});
  }

  String hashedPassword(String password) {
    String hashed = '';
    for (int i = 0; i < password.length; i++) {
      hashed += "#";
    }
    return hashed;
  }

  @override
  Widget build(BuildContext context) {
    print("isUser: $isUser");
    checkUser();
    print("isUser: $isUser");
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Scaffold(
        appBar: PagesAppBar(context, context.tr("profile")),
        body: isUser
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Icon(
                        Icons.person_rounded,
                        size: 150,
                        color: Colors.teal[900],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.tr("name"),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.teal,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                userData!['name'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                  fontSize: 17,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.tr("email"),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.teal,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                userData!['email'],
                                textAlign: TextAlign.center,
                                style: const TextStyle(fontSize: 13),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                context.tr("password"),
                                textAlign: TextAlign.center,
                                style: const TextStyle(
                                    color: Colors.teal,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              Text(
                                hashedPassword(userData!['password']),
                                style: const TextStyle(fontSize: 17),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    // TextButton(
                    //     onPressed: () {
                    //       // myDialog();
                    //     },
                    //     child: const Text("change password",
                    //         style: TextStyle(color: Colors.black)))
                  ],
                ),
              )
            : Center(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Icon(
                      Icons.person_rounded,
                      size: 150,
                      color: Colors.teal[900],
                    ),
                  ),
                  Text("Login to see your profile"),
                  const SizedBox(
                    height: 10,
                  ),
                  FilledButton(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginPage(),
                        )),
                    child: Text(
                      tr('log_in'),
                    ),
                  ),
                ],
              )),
      ),
    );
  }
}
