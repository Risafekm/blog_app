import 'package:hive/hive.dart';
part 'user_model.g.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  late String id;

  @HiveField(1)
  late String username;

  @HiveField(2)
  late String email;

  @HiveField(3)
  late String password;

  @HiveField(4)
  late bool isBanned;

  UserModel({
    required this.email,
    required this.id,
    required this.isBanned,
    required this.password,
    required this.username,
  });
}
