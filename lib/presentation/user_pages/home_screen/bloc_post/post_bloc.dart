import 'package:bloc/bloc.dart';
import 'package:blog_app/core/models/postmodel/post_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostAdding>(_onPostAdding);
    on<PostSearch>(_onPostSearch);
  }

  void _onPostAdding(PostAdding event, Emitter<PostState> emit) async {
    try {
      var box = await Hive.openBox<PostModel>('posts');
      int newId = box.length + 1;
      event.post.id = newId.toString();
      await box.add(event.post);
      emit(PostSuccess(await _getPublishedPosts()));
    } catch (e) {
      emit(PostFailure(e.toString()));
    }
  }

  void _onPostSearch(PostSearch event, Emitter<PostState> emit) async {
    try {
      final box = await Hive.openBox<PostModel>('posts');
      final posts = box.values
          .where((post) =>
              post.isPublished &&
              post.title.toLowerCase().contains(event.query.toLowerCase()))
          .toList();
      print('Search Results Length: ${posts.length}'); // Debug statement
      print('Search Results: $posts'); // Debug statement
      emit(PostSearchResults(results: posts));
    } catch (e) {
      emit(PostFailure(e.toString()));
    }
  }

  Future<List<PostModel>> _getPublishedPosts() async {
    final box = await Hive.openBox<PostModel>('posts');
    return box.values.where((post) => post.isPublished).toList();
  }
}
