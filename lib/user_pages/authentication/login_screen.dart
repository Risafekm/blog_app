import 'package:blog_app/core/const.dart';
import 'package:blog_app/user_pages/authentication/register_screen.dart';
import 'package:blog_app/user_pages/authentication/widgets/button_login.dart';
import 'package:blog_app/user_pages/authentication/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginUserScreen extends StatelessWidget {
  const LoginUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(height: 30),
              const SizedBox(height: 60),
              signInText(),
              const SizedBox(height: 5),
              subText(),
              // const SizedBox(height: 240),
              const SizedBox(height: 200),
              CustomTextFieldWidget(
                text: 'Email',
                icon: Icons.email,
              ),
              const SizedBox(height: 30),
              CustomTextFieldWidget(
                text: 'Password',
                icon: Icons.password,
              ),
              const SizedBox(height: 60),
              ButtonLogin(
                text: 'Login',
              ),
              const SizedBox(height: 8),
              dontHaveAccountText(context),
            ],
          ),
        ),
      ),
    );
  }

  Center dontHaveAccountText(context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => const RegistrationUserScreen())),
        child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              text: "Don't have an account ? ",
              style: GoogleFonts.roboto(
                fontSize: 13,
                color: Colors.black87,
              ),
              children: <TextSpan>[
                TextSpan(
                  text: '  SignUp',
                  style: GoogleFonts.roboto(
                    fontSize: 14,
                    color: spanlogincolor,
                  ),
                ),
              ]),
        ),
      ),
    );
  }

  Center subText() {
    return const Center(
      child: Text(
        'Enter your credential to login',
        style: TextStyle(
            fontSize: 14, fontWeight: FontWeight.w300, color: Colors.black54),
      ),
    );
  }

  Center signInText() {
    return Center(
      child: Text(
        'Welcome Back',
        style: GoogleFonts.roboto(
          fontSize: 36,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
