import 'dart:convert';
import 'package:http/http.dart' as http;

class Api {
  static const String baseUrl = '';

  static Future<Map<String, dynamic>> login(
      String username, String password) async {
    final response = await http.post(Uri.parse('$baseUrl/login'),
        body: {'username': username, 'password': password});

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to login');
    }
  }
}
