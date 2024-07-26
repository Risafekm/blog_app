// ignore_for_file: use_key_in_widget_constructors

import 'package:blog_app/hive_database/hive_database.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/bloc/auth_bloc.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/login_screen.dart';
import 'package:blog_app/presentation/user_pages/home_screen/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(hiveDatabase: HiveDatabase())..add(CheckAuthStatus()),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => HomeScreen(
                        user: state.user,
                      )),
            );
          } else if (state is AuthInitial) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginUserScreen()),
            );
          }
        },
        child: const Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}
