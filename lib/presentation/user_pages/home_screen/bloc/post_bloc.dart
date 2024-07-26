import 'package:bloc/bloc.dart';
import 'package:blog_app/core/models/postmodel/post_model.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(PostInitial()) {
    on<PostAdding>(_onPostAdding);
  }

  void _onPostAdding(PostAdding event, Emitter<PostState> emit) async {
    try {
      var box = await Hive.openBox<PostModel>('posts');
      await box.add(event.post);
      emit(PostSuccess());
    } catch (e) {
      emit(PostFailure(e.toString()));
    }
  }
}
