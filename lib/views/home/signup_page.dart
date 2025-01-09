import 'package:flutter/material.dart';
import 'package:tourist_guide/widgets/my_textformfield.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final RegExp emailRegExp = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final RegExp passwordRegExp = RegExp(
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
                  label: 'Full Name',
                  obsecureText: false,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    } else if (!nameRegExp.hasMatch(value)) {
                      return 'Invalid name';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              MyTextFormField(
                  label: 'Email',
                  obsecureText: false,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    } else if (!emailRegExp.hasMatch(value)) {
                      return 'Invalid email';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              MyTextFormField(
                  label: 'Phone Number ',
                  obsecureText: false,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    } else if (!phoneRegExp.hasMatch(value)) {
                      return 'Invalid phone number';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              MyTextFormField(
                  label: 'password',
                  obsecureText: true,
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
              const SizedBox(
                height: 16,
              ),
              SizedBox(
                width: double.infinity,
                child: _isLoading
                    ? const CircularProgressIndicator()
                    : OutlinedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            setState(() {
                              _isLoading = true;
                            });
                            // Simulate signup process
                            Future.delayed(const Duration(seconds: 2), () {
                              setState(() {
                                _isLoading = false;
                              });
                              // ignore: use_build_context_synchronously
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text('Signup Successful')),
                              );
                              Navigator.push(
                                // ignore: use_build_context_synchronously
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginPage()),
                              );
                            });
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

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Login")),
      body: const Center(child: Text("Login Page")),
    );
  }
}
