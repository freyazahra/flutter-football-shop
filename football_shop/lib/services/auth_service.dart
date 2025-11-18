import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:football_shop/services/api_client.dart';

class AuthService {
  static const _tokenKey = 'auth_token';
  static const _userIdKey = 'auth_user_id';

  static Future<void> saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<void> saveUserId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userIdKey, id);
  }

  static Future<String?> getUserId() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_userIdKey);
  }

  static Future<bool> isLoggedIn() async {
    final token = await getToken();
    return token != null && token.isNotEmpty;
  }

  static Future<bool> login(String username, String password) async {
    final api = ApiClient();
    final resp = await api.post(ApiClient.loginEndpoint, {
      'username': username,
      'password': password,
    });
    if (resp.statusCode == 200 || resp.statusCode == 201) {
      final data = jsonDecode(resp.body);
      // Expecting {'token': '...'} or {'token': '...', 'user': {'id': 1}}
      final token = data['token'] ?? data['auth_token'];
      if (token != null) {
        await saveToken(token);
        final user = data['user'];
        if (user != null && user['id'] != null) {
          await saveUserId(user['id'].toString());
        }
        return true;
      }
    }
    return false;
  }

  static Future<bool> register(String username, String password, String email) async {
    final api = ApiClient();
    final resp = await api.post(ApiClient.registerEndpoint, {
      'username': username,
      'password': password,
      'email': email,
    });
    return resp.statusCode == 200 || resp.statusCode == 201;
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_userIdKey);
  }
}
