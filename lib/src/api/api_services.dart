import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Api {
  static const baseUrl = 'https://products-9q0g.onrender.com';

  // Authentication

  static Future<String?> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/auth/login'),
      body: {'username': username, 'password': password},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      final token = data['access_token'];

      // Save token to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('access_token', token);

      return token;
    } else {
      throw Exception('Failed to log in');
    }
  }

  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  // User Endpoints

  static Future<Map<String, dynamic>> getProfile() async {
    final token = await getAuthToken();

    final response = await http.get(
      Uri.parse('$baseUrl/auth/profile'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to get profile');
    }
  }

  // ... Repeat the above pattern for other endpoints

  // Example for users endpoint
  static Future<Map<String, dynamic>> findUsers() async {
    final token = await getAuthToken();

    final response = await http.get(
      Uri.parse('$baseUrl/users/find'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to find users');
    }
  }
}
