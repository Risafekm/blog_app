import 'package:hive/hive.dart';
part 'post_model.g.dart';

@HiveType(typeId: 1)
class PostModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String title;

  @HiveField(2)
  late String content;

  @HiveField(3)
  late String authorId;

  @HiveField(4)
  late bool isPublished;

  @HiveField(5)
  late String response;

  PostModel({
    required this.id,
    required this.content,
    required this.authorId,
    required this.isPublished,
    required this.response,
    required this.title,
  });
}
