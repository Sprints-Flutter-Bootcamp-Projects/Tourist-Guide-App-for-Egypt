import 'package:flutter/material.dart';

Form editProfile() {
  return Form(
    child: Column(
      children: [
        Text(
          'Edit Profile',
          style: TextStyle(
            color: Colors.teal[700],
            fontSize: 20,
          ),
        ),
        TextFormField(),
        TextFormField(),
      ],
    ),
  );
}
