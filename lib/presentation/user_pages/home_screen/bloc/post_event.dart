// post_event.dart

part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

// Add post event
class PostAdding extends PostEvent {
  final PostModel post;

  PostAdding(this.post);
}
