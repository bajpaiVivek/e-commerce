import '../services/auth_services.dart';
import 'package:flutter/material.dart';
import '../models/user_model/user.dart';

class HomeScreen extends StatelessWidget {
  final User user;
  const HomeScreen({super.key, required this.user});

  void _logout(BuildContext context) async {
    await AuthenticationService.cleartoken();

    if (context.mounted) return;
    Navigator.of(context).pushReplacementNamed('/login');
  }

  void _openUserProfile(BuildContext context) {
    Navigator.pop(context);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => UserProfilePage(user: user)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Welcome'),
        actions: [
          IconButton(
            icon: const Icon(Icons.account_circle),
            onPressed: () => _openUserProfile(context),
          ),
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome, ${user.username}!',
                      style:
                          const TextStyle(fontSize: 18, color: Colors.white)),
                  const SizedBox(height: 8),
                  Text('Email: ${user.email}',
                      style:
                          const TextStyle(fontSize: 14, color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              title: const Text('User Profile'),
              onTap: () => _openUserProfile(context),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Username: ${user.username}'),
          const SizedBox(
            height: 20,
          ),
          Text('Email: ${user.email}'),
          const SizedBox(
            height: 20,
          ),
          Text('Role: ${user.role}'),
        ]),
      ),
    );
  }
}

class UserProfilePage extends StatelessWidget {
  final User user;
  const UserProfilePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Username: ${user.username}'),
            const SizedBox(
              height: 20,
            ),
            Text('Email: ${user.email}'),
            const SizedBox(
              height: 20,
            ),
            Text('Role: ${user.role}'),
          ],
        ),
      ),
    );
  }
}
