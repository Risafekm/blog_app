import 'package:blog_app/core/const.dart';
import 'package:blog_app/user_pages/authentication/login_screen.dart';
import 'package:blog_app/user_pages/authentication/widgets/button_login.dart';
import 'package:blog_app/user_pages/authentication/widgets/custom_textfield_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RegistrationUserScreen extends StatelessWidget {
  const RegistrationUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              signUpText(),
              const SizedBox(height: 5),
              subText(),
              // const SizedBox(height: 200),
              const SizedBox(height: 140),

              CustomTextFieldWidget(
                text: 'Username',
                icon: Icons.person,
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                text: 'Email',
                icon: Icons.email,
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                text: 'Password',
                icon: Icons.password,
              ),
              const SizedBox(height: 20),
              CustomTextFieldWidget(
                text: 'Confirm Password',
                icon: Icons.password,
              ),
              const SizedBox(height: 60),
              ButtonLogin(
                text: 'Register',
              ),
              const SizedBox(height: 8),
              alreadyHaveAccountText(context),
            ],
          ),
        ),
      ),
    );
  }

  Center alreadyHaveAccountText(context) {
    return Center(
      child: GestureDetector(
        onTap: () => Navigator.push(context,
            MaterialPageRoute(builder: (context) => const LoginUserScreen())),
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
