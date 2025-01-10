import 'package:flutter/material.dart';
import 'package:tourist_guide/views/authentication/login_page.dart';
import 'package:tourist_guide/widgets/my_textformfield.dart';

import '../../helpers/shared_pref.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  RegExp passwordRegExp = RegExp(
      r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{9,}$');
  final RegExp phoneRegExp = RegExp(r'^\+?1?\d{9,15}$');
  final RegExp nameRegExp = RegExp(r'^[a-zA-Z\s]+$');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign Up",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: Color(0xFF004D40)),
        ),
        centerTitle: true,
        actions: const [
          Icon(
            Icons.language,
            color: Color(0xFF004D40),
          ),
          SizedBox(
            width: 8,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Image.asset("Assets/images/logo.png")),
              const SizedBox(
                height: 16,
              ),
              const Text(
                "Tourist Guide",
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF004D40)),
              ),
              const SizedBox(
                height: 32,
              ),
              MyTextFormField(
                  controller: nameController,
                  label: 'Full Name',
                  labelIcon: Icons.person_outlined,
                  obsecureText: false,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else if (!nameRegExp.hasMatch(value)) {
                      return 'Invalid name';
                    }
                    return null;
                  }),
              MyTextFormField(
                  controller: emailController,
                  label: 'Email',
                  labelIcon: Icons.email_outlined,
                  obsecureText: false,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRegExp.hasMatch(value)) {
                      return 'Invalid email';
                    }
                    return null;
                  }),
              MyTextFormField(
                  controller: phoneController,
                  label: 'Phone Number ',
                  labelIcon: Icons.phone_outlined,
                  obsecureText: false,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (!phoneRegExp.hasMatch(value)) {
                      return 'Invalid phone number';
                    }
                    return null;
                  }),
              MyTextFormField(
                  controller: passwordController,
                  label: 'Password',
                  labelIcon: Icons.lock_outlined,
                  obsecureText: true,
                  isPassword: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    } else if (!passwordRegExp.hasMatch(value)) {
                      return '''Password must be at least 9 characters:
                      include an uppercase letter,
                      a lowercase letter,
                      a special character
                      and a number''';
                    }
                    return null;
                  }),
              SizedBox(
                width: double.infinity,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : OutlinedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            // Construct user data map
                            Map<String, dynamic> userData = {
                              'name': nameController.text,
                              'email': emailController.text,
                              'phone': phoneController.text,
                              'password': passwordController.text,
                            };

                            await SharedPreferencesHelper.saveUserData(
                                userData);

                            // Show success message
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Signup Successful')),
                            );

                            // Debug prints
                            print(userData);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const LoginPage()),
                            );
                          }
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: const Color(0xFF00695C),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(6)),
                        ),
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
