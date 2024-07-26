import 'package:hive/hive.dart';

class AdminAuthBox {
  static const _authBoxName = 'auth_box';
  static const _authStatusKey = 'auth_status';
  static const _adminStatusKey = 'admin_status';

  static late Box _box;

  static Future<void> init() async {
    _box = await Hive.openBox(_authBoxName);
  }

  static Future<void> saveAuthStatus(bool isAuthenticated,
      {bool isAdmin = false}) async {
    await _box.put(_authStatusKey, isAuthenticated);
    await _box.put(_adminStatusKey, isAdmin);
  }

  static bool getAuthStatus() {
    return _box.get(_authStatusKey, defaultValue: false);
  }

  static bool getAdminStatus() {
    return _box.get(_adminStatusKey, defaultValue: false);
  }
}
