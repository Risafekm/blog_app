// ignore_for_file: use_key_in_widget_constructors

import 'package:blog_app/presentation/admin_pages/admin_auth/admin_login.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/login_screen.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            labelColor: Colors.blue,
            indicatorSize: TabBarIndicatorSize.tab,
            labelStyle: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            indicator: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.blue),
                top: BorderSide(color: Colors.blue),
                left: BorderSide(color: Colors.blue),
                right: BorderSide(color: Colors.blue),
              ),
            ),
            tabs: [
              Tab(text: 'User'),
              Tab(text: 'Admin'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            LoginUserScreen(),
            LoginAdminScreen(),
          ],
        ),
      ),
    );
  }
}
