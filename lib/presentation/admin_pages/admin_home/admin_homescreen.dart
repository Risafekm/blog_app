// ignore_for_file: no_leading_underscores_for_local_identifiers, avoid_print

import 'package:blog_app/hive_database/hive_admin.dart';
import 'package:blog_app/core/const.dart';
import 'package:blog_app/core/models/postmodel/post_model.dart';
import 'package:blog_app/presentation/admin_pages/admin_auth/bloc/admin_bloc.dart';
import 'package:blog_app/presentation/admin_pages/admin_ban_user/ban_user.dart';
import 'package:blog_app/presentation/admin_pages/admin_profile/admin_profile.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/widgets/button_login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AdminBloc(hiveDatabase: AdminAuthBox()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: appbarbackground,
          title: Text(
            'Admin Home',
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
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const BanUserAccount()),
                );
              },
              icon: Icon(
                Icons.lock_person_outlined,
                color: appbaritemcolor,
              ),
            ),
            const SizedBox(width: 20),
            IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminProfileScreen(
                            adminName: 'Angel',
                            adminEmail: 'admin123@gmail.com',
                          )),
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Center(
                child: Text(
                  'Blogs',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
              ),
              const SizedBox(height: 20),
              // Listview blog
              Container(
                constraints: const BoxConstraints(
                    maxHeight: double.maxFinite, maxWidth: double.maxFinite),
                child: ValueListenableBuilder(
                  valueListenable: Hive.box<PostModel>('posts').listenable(),
                  builder: (context, Box<PostModel> box, _) {
                    if (box.values.isEmpty) {
                      return const Center(
                        child: Text('No posts available'),
                      );
                    }
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: box.values.length,
                      itemBuilder: (context, index) {
                        final post = box.getAt(index) as PostModel;

                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: 150,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: colorList[index % colorList.length],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 30,
                                    child: Text(
                                      post.id,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 30),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          post.title,
                                          style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.ellipsis),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "User Q   : ${post.content}",
                                          maxLines: 3,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.purple,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Admin R : ${post.response}",
                                          maxLines: 3,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.indigo,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Column(
                                    children: [
                                      // Checkbox for approval
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 50,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Publish",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          Checkbox(
                                            value: post.isPublished,
                                            onChanged: (bool? newValue) {
                                              if (newValue != null) {
                                                post.isPublished = newValue;
                                                post.save();
                                                print("${post.isPublished}");
                                              }
                                            },
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 50),
                                      // reply textfield
                                      Row(
                                        children: [
                                          Container(
                                            height: 20,
                                            width: 45,
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                            child: const Center(
                                              child: Text(
                                                "Reply",
                                                style: TextStyle(fontSize: 13),
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 5),
                                          IconButton(
                                            icon: const Icon(Icons.reply),
                                            onPressed: () {
                                              _showResponseBottomSheet(
                                                  context, post);
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showResponseBottomSheet(BuildContext context, PostModel post) {
    final TextEditingController _responseController = TextEditingController();
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Respond to Post',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: 50),
              TextField(
                controller: _responseController,
                decoration: InputDecoration(
                  hintText: 'Answer please...',
                  border: OutlineInputBorder(
                    borderSide: const BorderSide(color: Colors.black),
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              const SizedBox(height: 30),
              ButtonLogin(
                  text: "Reply Send",
                  onPressed: () {
                    final response = _responseController.text;
                    if (response.isNotEmpty) {
                      post.response = response;
                      post.save();
                      Navigator.pop(context);
                      print("Response saved: $response");
                    }
                  })
            ],
          ),
        );
      },
    );
  }
}
