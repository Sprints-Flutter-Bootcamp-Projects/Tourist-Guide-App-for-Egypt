import 'package:flutter/material.dart';

class MyTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final IconData labelIcon;
  final String? Function(String?)? validator;
  final bool isPassword;
  bool obsecureText;

  MyTextFormField(
      {super.key,
      required this.controller,
      required this.label,
      required this.labelIcon,
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextFormField(
        controller: widget.controller,
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
          prefixIcon: Icon(
            widget.labelIcon,
            color: Colors.teal,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(width: 1, color: Colors.grey),
          ),
          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: Color(0xFF004D40),
            ),
          ),
        ),
        obscureText: widget.obsecureText,
        validator: widget.validator,
      ),
    );
  }
}
