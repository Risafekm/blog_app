part of 'post_bloc.dart';

@immutable
sealed class PostEvent {}

class PostAdding extends PostEvent {
  final PostModel post;

  PostAdding(this.post);
}

class PostSearch extends PostEvent {
  final String query;

  PostSearch(this.query);
}
