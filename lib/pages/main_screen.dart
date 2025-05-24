import 'package:flutter/material.dart';
import 'products_page.dart';
import 'profile_page.dart';
import 'login_page.dart';
import '../models/user.dart';

class MainScreen extends StatefulWidget {
  final User? loggedInUser;

  const MainScreen({super.key, this.loggedInUser});

  @override
  State<MainScreen> createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  Set<int> _likedProducts = {};

  void _toggleLike(int productId) {
    setState(() {
      if (_likedProducts.contains(productId)) {
        _likedProducts.remove(productId);
      } else {
        _likedProducts.add(productId);
      }
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void clearLikedProducts() {
    setState(() {
      _likedProducts.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> _widgetOptions = <Widget>[
      ProductsPage(
        likedProducts: _likedProducts,
        toggleLike: _toggleLike,
      ),
      ProfilePage(loggedInUser: widget.loggedInUser),
    ];

    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.shopping_bag_outlined),
            label: 'ផលិតផល', // Products in Khmer
            tooltip: 'ផលិតផល', // Tooltip for accessibility
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person_outline),
            label: 'ប្រវត្តិរូប', // Profile in Khmer
            tooltip: 'ប្រវត្តិរូប', // Tooltip for accessibility
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey, // Make unselected icons visible
        onTap: _onItemTapped,
        selectedLabelStyle: const TextStyle(
          fontFamily: 'Noto Sans Khmer', // Apply Khmer font
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'Noto Sans Khmer', // Apply Khmer font
        ),
      ),
    );
  }
}