import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiClient {
  // TODO: set this to your deployed Django API base URL
  static const String baseUrl = 'https://your-django-api.example.com';

  // Endpoints (adjust if your API uses different paths)
  static const String loginEndpoint = '/api/auth/login/';
  static const String registerEndpoint = '/api/auth/register/';
  static const String itemsEndpoint = '/api/items/';

  final String? token;

  ApiClient({this.token});

  Map<String, String> _headers() {
    final headers = {'Content-Type': 'application/json'};
    if (token != null && token!.isNotEmpty) {
      // Common Django token header; change to 'Bearer' if your backend uses JWT
      headers['Authorization'] = 'Token $token';
    }
    return headers;
  }

  Uri _uri(String path) => Uri.parse(baseUrl + path);

  Future<http.Response> get(String path) async {
    return http.get(_uri(path), headers: _headers());
  }

  Future<http.Response> post(String path, Map body) async {
    return http.post(_uri(path), headers: _headers(), body: jsonEncode(body));
  }
}
