import 'package:flutter/material.dart';
import '../api_auth/api.dart';
import '../models/user_model/user.dart';
import '../services/auth_services.dart';
import '../screens/home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  void _login() async {
    final username = _usernameController.text;
    final password = _passwordController.text;

    try {
      final result = await Api.login(username, password);

      final user = User(
        username: result['username'],
        email: result['email'],
        role: result['role'],
      );

      await AuthenticationService.saveToken(result['token']);
      if (!mounted) return;
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => HomeScreen(user: user)),
      );
    } catch (e) {
      _showErrorDialog(
          'Login Failed', 'Invalid credentials. Please try again.');
    }
  }

  void _showErrorDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('ok'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username')),
              TextField(
                  controller: _passwordController,
                  obscureText: true,
                  decoration: const InputDecoration(labelText: 'Password')),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(onPressed: _login, child: const Text('Login'))
            ],
          ),
        ),
      ),
    );
  }
}
