import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tourist_guide/blocs/authentication/auth_bloc.dart';
import 'package:tourist_guide/models/firebase_models/firebase_user.dart';
import 'package:tourist_guide/models/user.dart';
import 'package:tourist_guide/views/authentication/login_page.dart';
import 'package:tourist_guide/utils/widgets/my_textformfield.dart';
import 'package:tourist_guide/views/home/home_page.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
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
        title: Text(context.tr('sign_up')),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(32.0),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
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
                style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF004D40)),
              ),
              const SizedBox(
                height: 24,
              ),
              MyTextFormField(
                  controller: firstNameController,
                  label: context.tr("first_name"),
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
                  controller: lastNameController,
                  label: context.tr("last_name"),
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
                  label: context.tr("email"),
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
                  label: context.tr("phone"),
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
                  label: context.tr("password"),
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
                child: BlocConsumer<AuthBloc, AuthState>(
                  listener: (context, state) {
                    //checking whether user exits in the local database
                    if (state is AuthAuthenticated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content:
                                Text(context.tr('this User already exists'))),
                      );
                    }
                    if (state is AuthUnauthenticated) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(context.tr('signup_successful'))),
                      );

                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is AuthLoading) {
                      return const CircularProgressIndicator();
                    }
                    if (state is AuthAuthenticated) {
                      // Show success message
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                            content: Text(context.tr('signup_successful'))),
                      );
                      Navigator.pop(context);
                    }
                    return OutlinedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // create a firebase user object
                          FirebaseUser newUser = FirebaseUser(
                            firstName: firstNameController.text,
                            lastName: lastNameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            phone: phoneController.text,
                          );

                          context
                              .read<AuthBloc>()
                              .add(FirebaseSignUpRequested(newUser));

                          // if (kDebugMode) {
                          //   print(newUser.toJson());
                          // }
                        }
                      },
                      style: OutlinedButton.styleFrom(
                        backgroundColor: const Color(0xFF00695C),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6)),
                      ),
                      child: Text(
                        context.tr("sign_up"),
                        style:
                            const TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    );
                  },
                ),
              ),
              TextButton(
                onPressed: () => Navigator.pushReplacement(
                  context,
                  PageTransition(
                    type: PageTransitionType.rightToLeftWithFade,
                    duration: Durations.extralong3,
                    child: const LoginPage(),
                  ),
                ),
                child: Text(
                  context.tr('have_an_account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
