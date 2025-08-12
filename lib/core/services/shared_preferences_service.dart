import 'dart:convert';
import 'package:ecommerce_app/features/auth/data/models/responses/auth_response/user_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static SharedPreferences? _prefs;

  static Future init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  Future setToken(String value) async {
    await _prefs?.setString('token', value);
  }

  Future<String?> getToken() async {
    return _prefs?.getString('token');
  }

  Future clearToken() async {
    await _prefs?.remove('token');
  }

  Future setUser(UserInfo user) async {
    await _prefs?.setString('user', jsonEncode(user.toJson()));
  }

  Future<UserInfo?> getUser() async {
    var user = _prefs?.getString('user');
    if (user != null) {
      return UserInfo.fromJson(jsonDecode(user));
    }
    return null;
  }
}
