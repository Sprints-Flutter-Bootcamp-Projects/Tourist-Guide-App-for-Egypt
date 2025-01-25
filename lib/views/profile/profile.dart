//customizalbe flutter moji
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/navigation/app_drawer.dart';
import 'package:tourist_guide/views/authentication/login_page.dart';
import 'package:fluttermoji/fluttermoji.dart';


class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isUser = false;
  Map<String, dynamic>? userData;

  void checkUser() async {
    userData = await SharedPreferencesHelper.getUserData();
    if (userData != null) {
      // print('Profile User data: $userData');
      isUser = true;
    } else {
      // print("No user data found.");
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
    checkUser();
    return Scaffold(
      appBar: AppBar(title: Text(tr("profile"))),
      drawer: AppDrawer(),
      body: isUser
          ? Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FluttermojiCustomizer(),
                            ),
                          );
                        },
                        child: FluttermojiCircleAvatar(
                          radius: 75,
                          backgroundColor: Colors.teal[100],
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
                  ],
                ),
              ),
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // FluttermojiCircleAvatar wrapped in InkWell
                Center(
                  child: InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FluttermojiCustomizer(),
                        ),
                      );
                    },
                    child: FluttermojiCircleAvatar(
                      radius: 75,
                      backgroundColor: Colors.teal[100],
                    ),
                  ),
                ),
                Text(
                  context.tr("no_profile_desc"),
                ),
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
    );
  }
}
