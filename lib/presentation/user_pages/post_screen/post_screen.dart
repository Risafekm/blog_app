import 'package:blog_app/core/const.dart';
import 'package:blog_app/core/models/postmodel/post_model.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/widgets/button_login.dart';
import 'package:blog_app/presentation/user_pages/authentication_user/widgets/custom_textfield_widget.dart';
import 'package:blog_app/presentation/user_pages/home_screen/bloc_post/post_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class PostScreen extends StatelessWidget {
  const PostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController();
    TextEditingController contentController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: appbarbackground,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: appbaritemcolor,
          ),
        ),
        title: Text(
          'Post',
          style: GoogleFonts.cabin(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            fontStyle: FontStyle.italic,
            color: appbaritemcolor,
          ),
        ),
      ),
      body: BlocListener<PostBloc, PostState>(
        listener: (context, state) {
          if (state is PostSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: const Text('Post added successfully!'),
              backgroundColor: successcolor,
            ));
            Navigator.pop(context);
          } else if (state is PostFailure) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text('Failed to add post: ${state.error}'),
              backgroundColor: errorcolor,
            ));
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                const SizedBox(height: 60),
                CustomTextFieldWidget(
                  text: 'Title',
                  icon: Icons.title,
                  controller: titleController,
                ),
                const SizedBox(height: 20),
                CustomTextFieldWidget(
                  text: 'Content',
                  icon: Icons.content_paste_rounded,
                  controller: contentController,
                ),
                const SizedBox(height: 20),
                const SizedBox(height: 70),
                ButtonLogin(
                  onPressed: () {
                    PostModel newPost = PostModel(
                      id: '',
                      title: titleController.text,
                      content: contentController.text,
                      authorId: '',
                      isPublished: false, // or set it as needed
                      response: '', // or set it as needed
                    );
                    context.read<PostBloc>().add(PostAdding(newPost));
                  },
                  text: 'Post',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
