// ignore_for_file: must_be_immutable

import 'package:blog_app/core/animation/delayed_slide.dart';
import 'package:blog_app/core/const.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/bloc/auth_bloc.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/register_screen.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/widgets/button_login.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/widgets/custom_textfield_widget.dart';
import 'package:blog_app/presentation/user_pages/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginUserScreen extends StatelessWidget {
  ValueNotifier<bool> isVisibile = ValueNotifier<bool>(true);

  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  LoginUserScreen({super.key});

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    }
    final regex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!regex.hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Welcome: ${state.user.username}"),
            backgroundColor: successcolor,
          ));
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(user: state.user),
            ),
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text("Failure: ${state.error}")));
        } else if (state is UserBanned) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: const Text("Your account has been banned."),
              backgroundColor: errorcolor,
            ),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("3.jpg"),
                colorFilter:
                    ColorFilter.mode(Colors.white30, BlendMode.softLight),
                fit: BoxFit.cover,
              ),
            ),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  DelayedAnimation(
                      aniDuration: 900,
                      aniOffsetX: 0.0,
                      aniOffsetY: 1.0,
                      delayedAnimation: 800,
                      child: signInText()),
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
                      text: 'Email',
                      icon: Icons.email,
                      controller: emailController,
                      validator: _validateEmail,
                      suffix: const SizedBox(),
                      isObscured: false,
                    ),
                  ),
                  const SizedBox(height: 30),
                  DelayedAnimation(
                    aniDuration: 700,
                    aniOffsetX: 0.0,
                    aniOffsetY: 0.45,
                    delayedAnimation: 900,
                    child: ListenableBuilder(
                      listenable: isVisibile,
                      builder: (context, child) {
                        return CustomTextFieldWidget(
                          text: 'Password',
                          icon: Icons.password,
                          controller: passwordController,
                          validator: _validatePassword,
                          suffix: GestureDetector(
                            onTap: () {
                              isVisibile.value = !isVisibile.value;
                            },
                            child: isVisibile.value
                                ? const Icon(
                                    Icons.visibility_off,
                                    color: Colors.blueGrey,
                                  )
                                : const Icon(
                                    Icons.visibility,
                                    color: Colors.blue,
                                  ),
                          ),
                          isObscured: isVisibile.value,
                        );
                      },
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
                          text: 'Login',
                          onPressed: () {
                            if (_formKey.currentState?.validate() ?? false) {
                              BlocProvider.of<AuthBloc>(context).add(LoginUser(
                                email: emailController.text,
                                password: passwordController.text,
                              ));
                            }
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
                      child: dontHaveAccountText(context)),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center dontHaveAccountText(context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => RegistrationUserScreen())),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: 'Don\'t have an account ? ',
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: Colors.black87,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '  SignUp',
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
    return Center(
      child: Text(
        'Welcome Back',
        style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w300,
            color: Colors.blue.shade600),
      ),
    );
  }

  Center signInText() {
    return Center(
      child: Text(
        'SignIn',
        style: GoogleFonts.roboto(
            fontSize: 36, fontWeight: FontWeight.w600, color: Colors.blue),
      ),
    );
  }
}
