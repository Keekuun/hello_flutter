import 'package:shared_preferences/shared_preferences.dart';

class Store {
  Store._privateConstructor();

  static final Store instance = Store
      ._privateConstructor();

  SharedPreferences? _prefs;

  Future<void> init() async {
    try {
      _prefs = await SharedPreferences.getInstance();
    } catch(e) {
      print("SharedPreferences init error: $e");
    }
  }
}