import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/user_pages/authentication_user/bloc/auth_bloc.dart';
import 'package:blog_app/user_pages/authentication_user/register_screen.dart';
import 'package:blog_app/user_pages/authentication_user/widgets/button_login.dart';
import 'package:blog_app/user_pages/authentication_user/widgets/custom_textfield_widget.dart';
import 'package:blog_app/user_pages/home_screen/home_screen.dart';

class LoginUserScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

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
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("Welcome: ${state.user.username}")));
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const HomeScreen()));
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
                    const SizedBox(height: 200),
                    CustomTextFieldWidget(
                      text: 'Email',
                      icon: Icons.email,
                      controller: emailController,
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
                    BlocBuilder<AuthBloc, AuthState>(
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
                    const SizedBox(height: 8),
                    dontHaveAccountText(context),
                  ],
                ),
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
        'SignIn',
        style: GoogleFonts.roboto(
          fontSize: 36,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
