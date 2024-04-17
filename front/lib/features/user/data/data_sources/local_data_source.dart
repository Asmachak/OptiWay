import 'package:front/features/user/data/models/user_model.dart';
import 'package:hive/hive.dart';

class AuthLocalDataSource {
  UserModel? currentUser;
  String? _token;

  Future<void> initialize() async {
    await getCurrentUser();
  }

  Future<void> setCurrentUser(UserModel user) async {
    var box = await Hive.openBox('currentUser');
    await box.put('user', user);
    currentUser = user;
  }

  Future<void> getCurrentUser() async {
    var box = await Hive.openBox('currentUser');
    currentUser = box.get('user', defaultValue: null);
    _token = box.get('token', defaultValue: null);
  }

  Future<void> setToken(String token) async {
    var box = await Hive.openBox('currentUser');
    await box.put('token', token);
    _token = token;
  }

  Future<void> logout() async {
    var box = await Hive.openBox('currentUser');
    await box.clear();
    currentUser = null;
    _token = null;
  }

  Future<bool> isLoggedIn() async {
    var box = await Hive.openBox('currentUser');
    currentUser = box.get('user', defaultValue: null);
    _token = box.get('token', defaultValue: null);
    return currentUser != null && _token != null;
  }
 Future<void> refreshUserData() async {
    await getCurrentUser();
  }
  String? get token => _token;
}
