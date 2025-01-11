import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tourist_guide/helpers/shared_pref.dart';
import 'package:tourist_guide/views/authentication/signup_page.dart';
import 'package:tourist_guide/widgets/my_textformfield.dart';
import '../../nav_bar.dart';
import '../../widgets/app_bar.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isHiddenPassword = true;
  final _formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PagesAppBar(context, context.tr("log_in")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            // spacing: 15,
            children: [
              Center(
                //
                child: Icon(Icons.map_outlined,
                    size: 120, color: Colors.teal[900]),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                context.tr("title"),
                style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF004D40)),
              ),
              const SizedBox(
                height: 24,
              ),
              MyTextFormField(
                controller: emailController,
                label: context.tr('email'),
                labelIcon: Icons.email_outlined,
                validator: (value) {
                  if (value != null && value.isEmpty) {
                    return 'Email cannot be empty';
                  } else if (!(value!.contains('@'))) {
                    return 'Email must contain @[mail]';
                  }
                  return null;
                },
              ),
              // TextFormField(
              //   controller: emailController,
              //   decoration: InputDecoration(
              //     prefixIcon: const Icon(
              //       Icons.email_outlined,
              //       color: Colors.teal,
              //     ),
              //     labelText: tr('email'),
              //     enabledBorder: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(15),
              //       borderSide: const BorderSide(color: Colors.teal),
              //     ),
              //     // border: OutlineInputBorder(
              //     //   borderRadius: BorderRadius.circular(15),
              //     //   borderSide: const BorderSide(color: Colors.teal),
              //     // ),
              //   ),
              //   validator: (value) {
              //     if (value != null && value.isEmpty) {
              //       return 'Email cannot be empty';
              //     } else if (!(value!.contains('@'))) {
              //       return 'Email must contain @[mail]';
              //     }
              //     return null;
              //   },
              // ),
              MyTextFormField(
                  controller: passwordController,
                  label: context.tr("password"),
                  labelIcon: Icons.lock_outlined,
                  obsecureText: true,
                  isPassword: true,
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  }),
              // TextFormField(
              //   obscureText: isHiddenPassword,
              //   controller: passwordController,
              //   validator: (value) {
              //     if (value != null && value.length < 6) {
              //       return 'Password must contain 6 characters';
              //     }
              //     return null;
              //   },
              //   decoration: InputDecoration(
              //     labelText: tr('password'),
              //     enabledBorder: OutlineInputBorder(
              //         borderRadius: BorderRadius.circular(15),
              //         borderSide: const BorderSide(color: Colors.teal)),
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(15),
              //     ),
              //     prefixIcon: IconButton(
              //         color: Colors.teal,
              //         onPressed: () {
              //           togglePasswordVisibility();
              //         },
              //         icon: Icon(isHiddenPassword
              //             ? Icons.visibility
              //             : Icons.visibility_off)),
              //   ),
              // ),
              FilledButton(
                style: FilledButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6))),
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    // Retrieve saved user data
                    Map<String, dynamic>? userData =
                        await SharedPreferencesHelper.getUserData();
                    if (userData != null) {
                      print('User data: $userData');

                      // Compare entered credentials with stored data
                      if (emailController.text == userData!['email'] &&
                          passwordController.text == userData['password']) {
                        // Login successful
                        // Navigate to home page
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MyNavigationBar(),
                          ),
                          (route) => false,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Login Successful')),
                        );
                      } else {
                        // Invalid credentials
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Invalid email or password')),
                        );
                      }
                    } else {
                      // No user data found
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text('No account found. Please sign up.')),
                      );
                    }
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Please enter valid data')),
                    );
                  }
                  Navigator.pop(context);
                },
                child: Text(
                  context.tr('log_in'),
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.leftToRightWithFade,
                    duration: Durations.extralong3,
                    child: SignupPage(),
                  ),
                ),
                //  Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => const SignupPage(),
                //     )),
                child: Text(
                  tr('create_new_account'),
                ),
              ),
              // FilledButton(
              //   style: FilledButton.styleFrom(
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(6))),
              //   onPressed: () => Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (context) => const SignupPage(),
              //       )),
              //   child: Text(
              //     tr('create_new_account'),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
