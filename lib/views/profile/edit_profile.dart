// import 'package:easy_localization/easy_localization.dart';
// import 'package:flutter/material.dart';
// import 'package:tourist_guide/helpers/shared_pref.dart';

// Widget editProfile(
//     BuildContext context, String name, String email, String phone) {
//   TextEditingController nameController = TextEditingController();
//   nameController.text = name;
//   TextEditingController emailController = TextEditingController();
//   emailController.text = email;
//   TextEditingController phoneController = TextEditingController();
//   phoneController.text = phone;
//   // TextEditingController passwordController = TextEditingController();

//   return Dialog(
//       child: Container(
//     padding: const EdgeInsets.all(20),
//     child: Column(
//       mainAxisSize: MainAxisSize.min,
//       children: <Widget>[
//         TextField(
//           controller: nameController,
//           decoration: InputDecoration(hintText: name),
//         ),
//         TextField(
//           controller: emailController,
//           decoration: InputDecoration(hintText: email),
//         ),
//         TextField(
//           controller: phoneController,
//           decoration: InputDecoration(hintText: phone),
//         ),
//         const SizedBox(height: 10),
//         OutlinedButton(
//           style: OutlinedButton.styleFrom(
//             backgroundColor: const Color(0xFF00695C),
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
//           ),
//           onPressed: () async {
//             // Construct user data map
//             Map<String, dynamic> userData = {
//               'name': nameController.text,
//               'email': emailController.text,
//               'phone': phoneController.text,
//             };

//             await SharedPreferencesHelper.saveUserData(userData);
//             Navigator.pop(context);
//           },
//           child: Text(
//             tr("Save"),
//             style: const TextStyle(fontSize: 16, color: Colors.white),
//           ),
//         ),
//       ],
//     ),
//   ));
// }
