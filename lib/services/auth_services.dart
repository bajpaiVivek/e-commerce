import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model/user.dart';

class AuthService {
  final String baseUrl;

  AuthService({required this.baseUrl});

  Future<Map<String, dynamic>> login(String username, String password) async {
    final apiUrl = '$baseUrl/auth/login';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'username': username,
          'password': password,
        },
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        final String token = responseData['token'];

        // Save the token locally
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('token', token);

        // Fetch and return user profile data
        return await fetchProfile(token);
      } else {
        // Handle API error
        print('Login failed: ${responseData['message']}');
        return {'error': responseData['message']};
      }
    } catch (error) {
      // Handle network or unexpected errors
      print('Error during login: $error');
      return {'error': 'Unexpected error during login'};
    }
  }

  Future<Map<String, dynamic>> fetchProfile(String token) async {
    final apiUrl = '$baseUrl/auth/profile';

    try {
      final response = await http.get(
        Uri.parse(apiUrl),
        headers: {'Authorization': 'Bearer $token'},
      );

      final responseData = json.decode(response.body);

      if (response.statusCode == 200) {
        // Parse and return user profile data
        return UserModel.fromJson(responseData).toJson();
      } else {
        // Handle API error
        print('Failed to fetch profile: ${responseData['message']}');
        return {'error': responseData['message']};
      }
    } catch (error) {
      // Handle network or unexpected errors
      print('Error during profile fetch: $error');
      return {'error': 'Unexpected error during profile fetch'};
    }
  }
}
