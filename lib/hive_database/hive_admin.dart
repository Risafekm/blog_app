import 'package:hive/hive.dart';

class AdminAuthBox {
  static const _authBoxName = 'auth_box';
  static const _authStatusKey = 'auth_status';
  static const _adminStatusKey = 'admin_status';
  static const adminLoginBoxName = 'adminLoginBox';
  static const isAdminLoggedInKey = 'isAdminLoggedIn';

  static Future<void> init() async {
    await Hive.openBox(_authBoxName);
  }

  static Future<void> saveAuthStatus(bool isAuthenticated,
      {bool isAdmin = false}) async {
    final box = await Hive.openBox(_authBoxName);
    await box.put(_authStatusKey, isAuthenticated);
    await box.put(_adminStatusKey, isAdmin);

    final adminLoginBox = await Hive.openBox(adminLoginBoxName);
    await adminLoginBox.put(isAdminLoggedInKey, isAdmin);
  }

  static Future<bool> getAuthStatus() async {
    final box = await Hive.openBox(_authBoxName);
    return box.get(_authStatusKey, defaultValue: false);
  }

  static Future<bool> getAdminStatus() async {
    final box = await Hive.openBox(_authBoxName);
    return box.get(_adminStatusKey, defaultValue: false);
  }

  static Future<void> clearAuthStatus() async {
    final box = await Hive.openBox(_authBoxName);
    await box.put(_authStatusKey, false);
    await box.put(_adminStatusKey, false);

    final adminLoginBox = await Hive.openBox(adminLoginBoxName);
    await adminLoginBox.put(isAdminLoggedInKey, false);
  }
}
