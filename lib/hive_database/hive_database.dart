import 'package:blog_app/models/usermodel/user_model.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  static const String userBoxName = 'userBox';
  static const String currentUserKey = 'currentUserId';

  Future<void> addUser(UserModel user) async {
    var box = await Hive.openBox<UserModel>(userBoxName);
    await box.put(user.id, user);
  }

  Future<UserModel?> getUser(String id) async {
    var box = await Hive.openBox<UserModel>(userBoxName);
    return box.get(id);
  }

  Future<List<UserModel>> getAllUsers() async {
    var box = await Hive.openBox<UserModel>(userBoxName);
    return box.values.toList();
  }

  Future<void> deleteUser(String id) async {
    var box = await Hive.openBox<UserModel>(userBoxName);
    await box.delete(id);
  }

  Future<void> clearUsers() async {
    var box = await Hive.openBox<UserModel>(userBoxName);
    await box.clear();
  }

  // Get the current user
  Future<UserModel?> getCurrentUser() async {
    var box = await Hive.openBox<String>('appPreferences');
    final currentUserId = box.get(currentUserKey);
    if (currentUserId != null) {
      var userBox = await Hive.openBox<UserModel>(userBoxName);
      return userBox.get(currentUserId);
    }
    return null;
  }

  // Set the current user
  Future<void> setCurrentUser(String userId) async {
    var box = await Hive.openBox<String>('appPreferences');
    await box.put(currentUserKey, userId);
  }

  // Log out the current user
  Future<void> logoutUser() async {
    var box = await Hive.openBox<String>('appPreferences');
    await box.delete(currentUserKey);
  }
}
