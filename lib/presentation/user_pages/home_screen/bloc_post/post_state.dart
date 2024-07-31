part of 'post_bloc.dart';

@immutable
sealed class PostState {}

final class PostInitial extends PostState {}

final class PostSuccess extends PostState {
  final List<PostModel> posts;

  PostSuccess(this.posts);
}

final class PostFailure extends PostState {
  final String error;

  PostFailure(this.error);
}

final class PostSearchResults extends PostState {
  final List<PostModel> results;

  PostSearchResults({required this.results});
}
