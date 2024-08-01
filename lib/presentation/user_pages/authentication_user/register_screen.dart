// ignore_for_file: use_key_in_widget_constructors

import 'package:blog_app/core/animation/delayed_slide.dart';
import 'package:blog_app/core/const.dart';
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
            content: Text("Registration Success: ${state.user.username}"),
            backgroundColor: successcolor,
          ));
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        user: state.user,
                      )));
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Failure: ${state.error}"),
            backgroundColor: errorcolor,
          ));
        }
      },
      child: SafeArea(
        child: Scaffold(
          body: SingleChildScrollView(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("3.jpg"),
                  fit: BoxFit.cover,
                  colorFilter:
                      ColorFilter.mode(Colors.white30, BlendMode.softLight),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 30),
                  DelayedAnimation(
                      aniDuration: 900,
                      aniOffsetX: 0.0,
                      aniOffsetY: 1.0,
                      delayedAnimation: 800,
                      child: signUpText()),
                  const SizedBox(height: 5),
                  DelayedAnimation(
                      aniDuration: 900,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.35,
                      delayedAnimation: 1000,
                      child: subText()),
                  const SizedBox(height: 100),
                  DelayedAnimation(
                    aniDuration: 800,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.45,
                    delayedAnimation: 900,
                    child: CustomTextFieldWidget(
                      text: 'Username',
                      icon: Icons.person,
                      controller: usernameController,
                      isObscured: false,
                      suffix: const SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    aniDuration: 800,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.45,
                    delayedAnimation: 900,
                    child: CustomTextFieldWidget(
                      text: 'Email',
                      icon: Icons.email,
                      controller: emailController,
                      isObscured: false,
                      suffix: const SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    aniDuration: 700,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.45,
                    delayedAnimation: 900,
                    child: CustomTextFieldWidget(
                      text: 'Password',
                      icon: Icons.password,
                      controller: passwordController,
                      isObscured: false,
                      suffix: const SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    aniDuration: 700,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.45,
                    delayedAnimation: 900,
                    child: CustomTextFieldWidget(
                      text: 'Confirm Password',
                      icon: Icons.password,
                      controller: confirmPasswordController,
                      isObscured: false,
                      suffix: const SizedBox(),
                    ),
                  ),
                  const SizedBox(height: 60),
                  DelayedAnimation(
                    aniDuration: 500,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.35,
                    delayedAnimation: 900,
                    child: BlocBuilder<AuthBloc, AuthState>(
                      builder: (context, state) {
                        return ButtonLogin(
                          text: 'Register',
                          onPressed: () {
                            if (usernameController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    const Text("Please enter your username"),
                                backgroundColor: errorcolor,
                              ));
                              return;
                            }
                            if (emailController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text("Please enter your email"),
                                backgroundColor: errorcolor,
                              ));
                              return;
                            }
                            if (passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    const Text("Please enter your password"),
                                backgroundColor: errorcolor,
                              ));
                              return;
                            }
                            if (confirmPasswordController.text.isEmpty) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content:
                                    const Text("Please confirm your password"),
                                backgroundColor: errorcolor,
                              ));
                              return;
                            }
                            if (passwordController.text !=
                                confirmPasswordController.text) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: const Text("Passwords do not match"),
                                backgroundColor: errorcolor,
                              ));
                              return;
                            }
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
                          },
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  DelayedAnimation(
                      aniDuration: 500,
                      aniOffsetX: 0.0,
                      aniOffsetY: 0.35,
                      delayedAnimation: 1000,
                      child: alreadyHaveAccountText(context)),
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
          color: Colors.blue,
        ),
      ),
    );
  }
}
