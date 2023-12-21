import 'package:flutter/material.dart';
import '../src/api/api_services.dart';

class AuthProvider extends ChangeNotifier {
  String? _token;

  String? get token => _token;

  Future<void> login(String username, String password) async {
    try {
      final response = await Api.post(
        '/auth/login',
        {'username': username, 'password': password},
      );

      _token = response['token'];

      // Save token to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', _token!);

      notifyListeners();
    } catch (e) {
      // Handle errors
      print('Error: $e');
    }
  }

  Future<void> loadTokenFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    _token = prefs.getString('token');
    notifyListeners();
  }

  // Add logout functionality if needed
  Future<void> logout() async {
    _token = null;

    // Clear token from SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token');

    notifyListeners();
  }
}
