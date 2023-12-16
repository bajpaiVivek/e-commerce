import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  void _openUserProfile(BuildContext context) {
    Navigator.pop(context);
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
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.blue),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Welcome',
                      style: TextStyle(fontSize: 18, color: Colors.white)),
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
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('Username: {user.username}'),
          SizedBox(
            height: 20,
          ),
          Text('Email: {user.email}'),
          SizedBox(
            height: 20,
          ),
          Text('Role: {user.role}'),
        ]),
      ),
    );
  }
}
