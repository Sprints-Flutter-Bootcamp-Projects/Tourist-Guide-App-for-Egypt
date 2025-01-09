import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/widgets/app_bar.dart';

// class Profile extends StatefulWidget {
//   const Profile({
//     super.key,
//   });
//   @override
//   State<Profile> createState() => _ProfileState();
// }

class Profile extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesAppBar(context, context.tr("profile")),
      body: Column(
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
            padding: EdgeInsets.all(10.0),
            child: SizedBox(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                     Text(
                      context.tr("Name"),
                      textAlign: TextAlign.center,
                      style:
                         const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 15,
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
                      context.tr("Email"),
                      textAlign: TextAlign.center,
                      style:
                        const  TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      email,
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 15),
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
                      context.tr("Password"),
                      textAlign: TextAlign.center,
                      style:
                         const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      hashedPassword(password),
                      style: const TextStyle(fontSize: 15),
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
    );
  }

  // Future<void> myDialog() async {
  //   // dialog function
  //   return showDialog<void>(
  //     context: ,
  //     builder: (BuildContext context) {
  //       return const AlertDialog(
  //         title:  Text('AlertDialog'),
  //         content: Text("change password"),
  //         actions: <Widget>[
  //           TextField(
  //             decoration: InputDecoration(labelText: "new password"),
  //           ),
  //           TextField(decoration: InputDecoration(labelText: "confirm password"),),
  //         ],
  //       );
  //     },
  //   );
  // }
}

String hashedPassword(String password) {
  String hashed = '';
  for (int i = 0; i < password.length; i++) {
    hashed += "#";
  }
  return hashed;
}
