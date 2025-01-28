import 'package:flutter/material.dart';

// ignore: non_constant_identifier_names
Widget TextTitle(String title) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Text(title,
        style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.teal[900])),
  );
}
