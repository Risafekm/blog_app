// ignore_for_file: use_key_in_widget_constructors, sized_box_for_whitespace

import 'package:blog_app/core/const.dart';
import 'package:blog_app/presentation/admin_pages/admin_auth/bloc/admin_bloc.dart';
import 'package:blog_app/presentation/admin_pages/admin_home/admin_homescreen.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/widgets/button_login.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginAdminScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final adminEmailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 60),
                  signInText(),
                  const SizedBox(height: 5),
                  subText(),
                  const SizedBox(height: 100),
                  CustomTextFieldWidget(
                    text: 'Email',
                    icon: Icons.email,
                    controller: adminEmailController,
                    validator: _validateEmail,
                  ),
                  const SizedBox(height: 30),
                  CustomTextFieldWidget(
                    text: 'Password',
                    icon: Icons.password,
                    controller: passwordController,
                    validator: _validatePassword,
                  ),
                  const SizedBox(height: 60),
                  BlocListener<AdminBloc, AdminState>(
                    listener: (context, state) {
                      if (state is AdminLoginSuccess) {
                        // Navigate to another screen or show a success message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: const Text("login successfull"),
                            backgroundColor: successcolor,
                          ),
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AdminHomeScreen()));
                      } else if (state is AdminLoginFailure) {
                        // Show error message
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(state.error),
                            backgroundColor: errorcolor,
                          ),
                        );
                      }
                    },
                    child: ButtonLogin(
                      text: 'Login',
                      onPressed: () {
                        if (_formKey.currentState?.validate() ?? false) {
                          BlocProvider.of<AdminBloc>(context).add(
                            AdminLoginRequested(
                              email: adminEmailController.text,
                              password: passwordController.text,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center subText() {
    return const Center(
      child: Text(
        'Welcome Back',
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54),
      ),
    );
  }

  Center signInText() {
    return Center(
      child: Text(
        'Admin',
        style: GoogleFonts.roboto(
          fontSize: 36,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

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
}
