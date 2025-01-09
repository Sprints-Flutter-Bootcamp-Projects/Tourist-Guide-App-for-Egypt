import 'package:flutter/material.dart';

class MyTextFormField extends StatelessWidget {
  final String label;
  final bool obsecureText;
  final String? Function(String?)? validator;
  const MyTextFormField(
      {super.key,
      required this.label,
      required this.obsecureText,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelText: label,
          hintText: 'Enter your ${label.toLowerCase()}',
          focusColor: const Color(0xFF004D40),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF004D40)))),
      obscureText: obsecureText,
      validator: validator,
    );
  }
}
