import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final String label;
  bool obsecureText;
  final String? Function(String?)? validator;
  final bool isPassword;

  MyTextFormField(
      {super.key,
      required this.label,
      this.obsecureText = false,
      this.validator,
      this.isPassword = false});

  @override
  State<MyTextFormField> createState() => _MyTextFormFieldState();
}

class _MyTextFormFieldState extends State<MyTextFormField> {
  IconData? suffixIcon = Icons.visibility_off_outlined;

  void switchVisibility() {
    widget.obsecureText = !widget.obsecureText;
    suffixIcon = widget.obsecureText
        ? Icons.visibility_off_outlined
        : Icons.visibility_outlined;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? InkWell(
                  child: Icon(suffixIcon),
                  onTap: () => switchVisibility(),
                )
              : null,
          labelText: widget.label,
          hintText: 'Enter your ${widget.label.toLowerCase()}',
          focusColor: const Color(0xFF004D40),
          border: const OutlineInputBorder(),
          enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(width: 1, color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(width: 2, color: Color(0xFF004D40)))),
      obscureText: widget.obsecureText,
      validator: widget.validator,
    );
  }
}
