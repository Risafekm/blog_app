import 'package:blog_app/hive_database/hive_database.dart';
import 'package:blog_app/user_pages/authentication_user/bloc/auth_bloc.dart';
import 'package:blog_app/user_pages/authentication_user/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(hiveDatabase: HiveDatabase()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('HomeScreen'),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {
                BlocProvider.of<AuthBloc>(context).add(LogoutUser());
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginUserScreen()),
                );
              },
              icon: const Icon(Icons.logout),
            ),
          ],
        ),
        body: const Center(
          child: Text('Welcome to HomeScreen!'),
        ),
      ),
    );
  }
}
