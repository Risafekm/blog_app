// ignore_for_file: must_be_immutable

part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

//add post
class PostAdding extends PostEvent {
  late PostModel post;

  PostAdding(this.post);
}
