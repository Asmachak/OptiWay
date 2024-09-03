import 'package:front/features/organiser/data/models/organiser_model.dart';
import 'package:hive/hive.dart';

class OrganiserLocalDataSource {
  OrganiserModel? currentOrganiser;
  String? _token;

  Future<void> initialize() async {
    await getCurrentOrganiser();
  }

  Future<void> setCurrentOrganiser(OrganiserModel organiser) async {
    var box = await Hive.openBox('currentOrganiser');
    await box.put('organiser', organiser);
    currentOrganiser = organiser;
  }

  Future<void> getCurrentOrganiser() async {
    var box = await Hive.openBox('currentOrganiser');
    currentOrganiser = box.get('organiser', defaultValue: null);
    _token = box.get('token', defaultValue: null);
  }

  Future<void> setToken(String token) async {
    var box = await Hive.openBox('currentOrganiser');
    await box.put('token', token);
    _token = token;
  }

  Future<void> logout() async {
    var box = await Hive.openBox('currentOrganiser');
    await box.clear();
    currentOrganiser = null;
    _token = null;
  }

  Future<bool> isLoggedIn() async {
    var box = await Hive.openBox('currentOrganiser');
    currentOrganiser = box.get('organiser', defaultValue: null);
    _token = box.get('token', defaultValue: null);
    return currentOrganiser != null && _token != null;
  }

  Future<void> refreshOrganiserData() async {
    await getCurrentOrganiser();
  }

  String? get token => _token;
}
