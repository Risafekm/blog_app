// ignore_for_file: use_build_context_synchronously, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:blog_app/core/models/postmodel/post_model.dart';
import 'package:blog_app/presentation/user_pages/post_screen/post_screen.dart';
import 'package:blog_app/presentation/user_pages/profile_screen/profile_screen.dart';
import 'package:blog_app/presentation/user_pages/history_screen/history_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:blog_app/core/models/usermodel/user_model.dart';
import 'package:blog_app/core/const.dart';

import 'bloc_post/post_bloc.dart';

class HomeScreen extends StatelessWidget {
  final UserModel user;

  const HomeScreen({required this.user, super.key});

  @override
  Widget build(BuildContext context) {
    // Print Hive data when HomeScreen is initialized
    _printHiveData();

    return BlocProvider(
      create: (context) => PostBloc()..add(PostSearch('')),
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
                _printHiveData();
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
        body: Column(
          children: [
            const SizedBox(height: 20),

            // Search Bar
            BlocBuilder<PostBloc, PostState>(
              builder: (context, state) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextField(
                    onChanged: (query) {
                      print("Search Query: $query");
                      context.read<PostBloc>().add(PostSearch(query));
                    },
                    decoration: InputDecoration(
                      hintText: 'Search...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderSide: const BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            // Blog List
            Expanded(
              child: BlocBuilder<PostBloc, PostState>(
                builder: (context, state) {
                  // print to confirm BlocBuilder rebuild
                  print("Current State: ${state.runtimeType}");

                  if (state is PostInitial) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PostSearchResults) {
                    final posts = state.results;

                    if (posts.isEmpty) {
                      return const Center(child: Text('No posts found'));
                    }

                    return ListView.builder(
                      itemCount: posts.length,
                      itemBuilder: (context, index) {
                        final post = posts[index];
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
                                          "User  Q  : ${post.content}",
                                          maxLines: 3,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            color: Colors.purple,
                                            fontWeight: FontWeight.bold,
                                            overflow: TextOverflow.fade,
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                        Text(
                                          "Admin R : ${post.response}",
                                          maxLines: 3,
                                          style: const TextStyle(
                                            fontSize: 15,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.indigo,
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
                  } else if (state is PostFailure) {
                    return Center(child: Text('Error: ${state.error}'));
                  } else {
                    return const Center(child: Text('Something went wrong'));
                  }
                },
              ),
            ),
          ],
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

  Future<void> _printHiveData() async {
    final box = await Hive.openBox<PostModel>('posts');
    final posts = box.values.toList();
    for (var post in posts) {
      print('Post ID: ${post.id}, Title: ${post.title}');
    }
  }
}
