import 'package:front/features/admin/data/models/admin_model.dart';
import 'package:hive/hive.dart';

class AdminLocalDataSource {
  AdminModel? currentAdmin;
  String? _token;
  Box? _box;

  Future<void> initialize() async {
    await _openBox();
    await getCurrentAdmin();
  }

  Future<void> _openBox() async {
    _box ??= await Hive.openBox('currentAdmin');
  }

  Future<void> setCurrentAdmin(AdminModel admin) async {
    await _openBox();
    await _box!.put('admin', admin);
    currentAdmin = admin;
  }

  Future<void> getCurrentAdmin() async {
    await _openBox();
    currentAdmin = _box!.get('admin', defaultValue: null);
    _token = _box!.get('token', defaultValue: null);
  }

  Future<void> setToken(String token) async {
    await _openBox();
    await _box!.put('token', token);
    _token = token;
  }

  Future<void> logout() async {
    await _openBox();
    await _box!.clear();
    currentAdmin = null;
    _token = null;
  }

  Future<bool> isLoggedIn() async {
    await _openBox();
    currentAdmin = _box!.get('admin', defaultValue: null);
    _token = _box!.get('token', defaultValue: null);
    return currentAdmin != null && _token != null;
  }

  Future<void> refreshAdminData() async {
    await getCurrentAdmin();
  }

  String? get token => _token;
}
