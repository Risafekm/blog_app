import 'package:blog_app/core/const.dart';
import 'package:blog_app/presentation/admin_pages/admin_auth/bloc/admin_bloc.dart';
import 'package:blog_app/presentation/login.dart';
import 'package:blog_app/presentation/user_pages/profile_screen/widgets/buttonlogout.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminProfileScreen extends StatelessWidget {
  final String adminName;
  final String adminEmail;
  const AdminProfileScreen(
      {super.key, required this.adminEmail, required this.adminName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarbackground,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: appbaritemcolor,
          ),
        ),
        centerTitle: true,
        title: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            'Admin Account',
            style: GoogleFonts.cabin(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: appbaritemcolor,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            children: [
              profilepicAndEdit(),
              const SizedBox(
                height: 50,
              ),
              nameAndEmail(context),
              const SizedBox(
                height: 80,
              ),
              ButtonLogout(
                text: 'LogOut',
                onPressed: () {
                  BlocProvider.of<AdminBloc>(context)
                      .add(AdminLogoutRequested());
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget profilepicAndEdit() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          height: 200,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.blue,
                Colors.blue.shade100,
              ],
              begin: Alignment.topLeft,
              end: Alignment.center,
            ),
          ),
        ),
        const Positioned(
          bottom: -40,
          child: SizedBox(
            height: 110,
            width: 110,
            child: CircleAvatar(
              backgroundImage: AssetImage('dp.png'),
            ),
          ),
        ),
      ],
    );
  }

  Widget nameAndEmail(BuildContext context) {
    return Column(
      children: [
        Text(
          adminName,
          style: GoogleFonts.actor(
            textStyle: const TextStyle(
              fontSize: 22,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          adminEmail,
          style: GoogleFonts.adamina(
            textStyle: const TextStyle(
              fontSize: 14,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
