// ignore_for_file: use_key_in_widget_constructors

import 'package:blog_app/core/models/usermodel/user_model.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/bloc/auth_bloc.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/login_screen.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/widgets/button_login.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/widgets/custom_textfield_widget.dart';
import 'package:blog_app/presentation/user_pages/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationUserScreen extends StatelessWidget {
  final usernameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text("Registration Success: ${state.user.username}")));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        user: state.user,
                      )));
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Failure: ${state.error}")));
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  signUpText(),
                  const SizedBox(height: 5),
                  subText(),
                  const SizedBox(height: 140),
                  CustomTextFieldWidget(
                    text: 'Username',
                    icon: Icons.person,
                    controller: usernameController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFieldWidget(
                    text: 'Email',
                    icon: Icons.email,
                    controller: emailController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFieldWidget(
                    text: 'Password',
                    icon: Icons.password,
                    controller: passwordController,
                  ),
                  const SizedBox(height: 20),
                  CustomTextFieldWidget(
                    text: 'Confirm Password',
                    icon: Icons.password,
                    controller: confirmPasswordController,
                  ),
                  const SizedBox(height: 60),
                  BlocBuilder<AuthBloc, AuthState>(
                    builder: (context, state) {
                      return ButtonLogin(
                        text: 'Register',
                        onPressed: () {
                          if (passwordController.text ==
                              confirmPasswordController.text) {
                            final user = UserModel(
                              id: DateTime.now()
                                  .millisecondsSinceEpoch
                                  .toString(),
                              username: usernameController.text,
                              email: emailController.text,
                              password: passwordController.text,
                              isBanned: false,
                            );
                            BlocProvider.of<AuthBloc>(context)
                                .add(RegisterUser(user));
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    content: Text("Passwords do not match")));
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 8),
                  alreadyHaveAccountText(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center alreadyHaveAccountText(context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => LoginUserScreen())),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Already have an account ? ',
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: Colors.black87,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '  Login',
                  style: GoogleFonts.roboto(
                      fontSize: 14,
                      color: Colors.blue,
                      fontWeight: FontWeight.bold),
                ),
              ]),
        ),
      ),
    );
  }

  Center subText() {
    return const Center(
      child: Text(
        'Create your account',
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54),
      ),
    );
  }

  Center signUpText() {
    return Center(
      child: Text(
        'SignUp',
        style: GoogleFonts.roboto(
          fontSize: 36,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
