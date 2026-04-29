import 'package:shared_preferences/shared_preferences.dart';

class ApiHelper {
  static const String _accessTokenKey = 'access-token';
  static const String _refreshTokenKey = 'refresh-token';
  static const String _emailKey = "saved_email";
  static const String _passwordKey = "saved_password";

  /// save access token
  static Future<void> saveAccessToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, token);
  }

  /// save refresh token
  static Future<void> saveRefreshToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_refreshTokenKey, token);
  }

  /// get access token
  static Future<String> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey) ?? '';
  }

  /// get refresh token
  static Future<String> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey) ?? '';
  }

  /// delete
  static Future<void> deleteTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_accessTokenKey);
    await prefs.remove(_refreshTokenKey);
  }

  //  Save signup data
  static Future<void> saveLocalUser(String email, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_emailKey, email);
    await prefs.setString(_passwordKey, password);
  }

  //  get email
  static Future<String?> getEmail() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_emailKey);
  }

  //  get password
  static Future<String?> getPassword() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_passwordKey);
  }
}
