import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';
import 'package:tourist_guide/blocs/authentication/auth_bloc.dart';
import 'package:tourist_guide/utils/widgets/profile_pic.dart';
import 'package:tourist_guide/views/authentication/signup_page.dart';
import 'package:tourist_guide/utils/widgets/my_textformfield.dart';

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
      appBar: AppBar(title: Text(tr('login'))),
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
                style: const TextStyle(
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
              BlocConsumer<AuthBloc, AuthState>(
                listener: (context, state) {
                  if (state is AuthAuthenticated) {
                    // if (kDebugMode) {
                    //   print('User data: ${state.user.toJson()}');
                    // }

                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(context.tr('login_successful'))),
                    );
                  } else if (state is AuthUnauthenticated) {
                    // Invalid credentials
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                          content: Text(context.tr('invalid_credentials'))),
                    );
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.errorMsg)));
                  }
                },
                builder: (context, state) {
                  if (state is AuthLoading) {
                    return const CircularProgressIndicator();
                  }
                  return FilledButton(
                    style: FilledButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6))),
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        context.read<AuthBloc>().add(FirebaseLoginRequested(
                            emailController.text, passwordController.text));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content:
                                Text(context.tr('Please_enter_valid_data'))));
                      }
                    },
                    child: Text(
                      context.tr('log_in'),
                    ),
                  );
                },
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    PageTransition(
                      type: PageTransitionType.leftToRightWithFade,
                      duration: Durations.extralong3,
                      child: const SignupPage(),
                    ),
                  );
                },
                child: Text(
                  tr('create_new_account'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
