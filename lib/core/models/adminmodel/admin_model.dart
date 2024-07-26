import 'package:hive/hive.dart';
part 'admin_model.g.dart';

@HiveType(typeId: 3)
class AdminModel extends HiveObject {
  @HiveField(0)
  late String email;

  @HiveField(1)
  late String password;

  AdminModel({
    required this.email,
    required this.password,
  });
}
