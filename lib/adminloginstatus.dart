import 'package:blog_app/presentation/admin_pages/admin_auth/bloc/admin_bloc.dart';
import 'package:blog_app/presentation/admin_pages/admin_home/admin_homescreen.dart';
import 'package:blog_app/presentation/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'hive_database/hive_admin.dart';

class AdminLoginStatus extends StatelessWidget {
  const AdminLoginStatus({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AdminBloc(hiveDatabase: AdminAuthBox())..add(CheckAdminAuthStatus()),
      child: BlocListener<AdminBloc, AdminState>(
        listener: (context, state) async {
          if (state is AdminLoginSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const AdminHomeScreen()),
            );
          } else if (state is AdminInitial || state is AdminLoginFailure) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginScreen()),
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
