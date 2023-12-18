import 'package:flutter/material.dart';
import '../screens/bottomnav_screens/category_screen.dart';
import '../screens/bottomnav_screens/product_screen.dart';
import '../screens/bottomnav_screens/location_screen.dart';
import '../screens/bottomnav_screens/store_screen.dart';
import '../screens/bottomnav_screens/warehouse_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    CategoryScreen(),
    ProductScreen(),
    LocationScreen(),
    StoreScreen(),
    WarehouseScreen(),
  ];

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
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Products',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.location_on),
            label: 'Locations',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store),
            label: 'Stores',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.storage),
            label: 'Warehouses',
          ),
        ],
      ),
    );
  }
}
