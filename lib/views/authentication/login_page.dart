import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:tourist_guide/views/authentication/signup_page.dart';
import '../../nav_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHiddenPassword = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          tr('log_in'),
          style: TextStyle(fontSize: 20, color: Colors.teal.shade700),
        ),
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: SingleChildScrollView(
            child: Column(
              spacing: 15,
              children: [
                Image.asset('assets/images/logo.PNG'),
                TextFormField(
                  controller: emailController,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(
                      Icons.email_outlined,
                      color: Colors.teal,
                    ),
                    labelText: tr('email'),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: const BorderSide(color: Colors.teal),
                    ),
                  ),
                  validator: (value) {
                    if (value != null && value.isEmpty) {
                      return 'Email cannot be empty';
                    } else if (!(value!.contains('@'))) {
                      return 'Email must contain @[mail]';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  obscureText: isHiddenPassword,
                  controller: passwordController,
                  validator: (value) {
                    if (value != null && value.length < 6) {
                      return 'Password must contain 6 characters';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                    labelText: tr('password'),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: const BorderSide(color: Colors.teal)),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    prefixIcon: IconButton(
                        color: Colors.teal,
                        onPressed: () {
                          togglePasswordVisibility();
                        },
                        icon: Icon(isHiddenPassword
                            ? Icons.visibility
                            : Icons.visibility_off)),
                  ),
                ),
                FilledButton(
                  style: FilledButton.styleFrom(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6))),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      isLoggedIn = true;
                      Navigator.pop(context);
                    } else {
                      const ScaffoldMessenger(
                          child: SnackBar(
                              content: Text('Please Enter a valid data')));
                    }
                  },
                  child: Text(tr('log_in')),
                ),
                FilledButton(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignupPage(),
                        )),
                    child: Text(tr('create_new_account'))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  togglePasswordVisibility() {
    isHiddenPassword = !isHiddenPassword;
    setState(() {});
  }
}
