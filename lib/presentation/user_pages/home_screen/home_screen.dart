// ignore_for_file: use_build_context_synchronously

import 'package:blog_app/core/const.dart';
import 'package:blog_app/core/models/postmodel/post_model.dart';
import 'package:blog_app/core/models/usermodel/user_model.dart';
import 'package:blog_app/hive_database/hive_database.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/bloc/auth_bloc.dart';
import 'package:blog_app/presentation/user_pages/history_screen/history_screen.dart';
import 'package:blog_app/presentation/user_pages/post_screen/post_screen.dart';
import 'package:blog_app/presentation/user_pages/profile_screen/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

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
              onPressed: () async {
                if (!Hive.isBoxOpen('posts')) {
                  await Hive.openBox<PostModel>('posts');
                }
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => HistoryScreen(user: user)),
                );
              },
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
                  child: ValueListenableBuilder(
                    valueListenable: Hive.box<PostModel>('posts').listenable(),
                    builder: (context, Box<PostModel> box, _) {
                      final publishedPosts =
                          box.values.where((post) => post.isPublished).toList();

                      if (publishedPosts.isEmpty) {
                        return const Center(
                          child: Text('No published posts available'),
                        );
                      }

                      return ListView.builder(
                        shrinkWrap: true,
                        itemCount: publishedPosts.length,
                        itemBuilder: (context, index) {
                          final post = publishedPosts[index];
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: 150,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                color: Colors.blue.shade200,
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
                                                overflow:
                                                    TextOverflow.ellipsis),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            post.content,
                                            maxLines: 3,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                          const SizedBox(height: 10),
                                          Text(
                                            "admin reply : ${post.response}",
                                            maxLines: 3,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.purple,
                                              overflow: TextOverflow.fade,
                                            ),
                                          ),
                                        ],
                                      ),
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
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const PostScreen()));
          },
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }
}
