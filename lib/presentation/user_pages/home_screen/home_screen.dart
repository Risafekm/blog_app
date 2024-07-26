import 'package:blog_app/core/const.dart';
import 'package:blog_app/core/models/usermodel/user_model.dart';
import 'package:blog_app/hive_database/hive_database.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/bloc/auth_bloc.dart';
import 'package:blog_app/presentation/user_pages/profile_screen/profile_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  const HomeScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(hiveDatabase: HiveDatabase()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appbarbackground,
          title: Text(
            'Home',
            style: GoogleFonts.cabin(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic,
              color: appbaritemcolor,
            ),
          ),
          centerTitle: true,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.history,
                color: appbaritemcolor,
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(user: user)),
                );
              },
              icon: Icon(
                Icons.person,
                color: appbaritemcolor,
              ),
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),

                //searchbar
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10.0, right: 8.0, top: 5, bottom: 5),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Padding(
                  padding: EdgeInsets.only(left: 12),
                  child: Text(
                    'Blogs',
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
                  ),
                ),
                const SizedBox(height: 20),
                // listview blog
                Container(
                  constraints: const BoxConstraints(
                      maxHeight: double.maxFinite, maxWidth: double.maxFinite),
                  child: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 150,
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: Colors.blue.shade200,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
