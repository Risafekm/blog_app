import 'package:blog_app/core/models/usermodel/user_model.dart';
import 'package:hive/hive.dart';

class HiveDatabase {
  static const String userBoxName = 'userBox';
  static const String currentUserKey = 'currentUserId';
  static const String userLoginBoxName = 'userLoginBox';
  static const String isUserLoggedInKey = 'isUserLoggedIn';

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

  // Set user login status
  Future<void> setUserLoginStatus(bool isLoggedIn) async {
    var box = await Hive.openBox(userLoginBoxName);
    await box.put(isUserLoggedInKey, isLoggedIn);
  }

  // Get user login status
  Future<bool> getUserLoginStatus() async {
    var box = await Hive.openBox(userLoginBoxName);
    return box.get(isUserLoggedInKey, defaultValue: false);
  }

  // Ban a user
  Future<void> banUser(String id) async {
    var box = await Hive.openBox<UserModel>(userBoxName);
    UserModel? user = box.get(id);
    if (user != null) {
      user.isBanned = true;
      await user.save();
    }
  }

  // Unban a user
  Future<void> unbanUser(String id) async {
    var box = await Hive.openBox<UserModel>(userBoxName);
    UserModel? user = box.get(id);
    if (user != null) {
      user.isBanned = false;
      await user.save();
    }
  }
}
