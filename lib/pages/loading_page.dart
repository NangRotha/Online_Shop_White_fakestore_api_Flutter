// lib/pages/loading_page.dart
import 'package:flutter/material.dart';
import 'login_page.dart';

class LoadingPage extends StatefulWidget {
  const LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    super.initState();
    // Simulate a loading delay, adjust duration as needed
    Future.delayed(const Duration(seconds: 3), () {
      // Navigate to the LoginPage and remove the LoadingPage from the history
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueAccent, // A primary color for the background
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // App Icon/Logo
            Icon(
              Icons.shopping_bag_outlined, // A shopping bag icon
              size: 120,
              color: Colors.white, // White color for contrast
            ),
            SizedBox(height: 30),
            // App Name in Khmer
            Text(
              'កម្មវិធីហាង', // Shop App in Khmer
              style: TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                letterSpacing: 2,
                fontFamily: 'Noto Sans Khmer', // Apply Khmer font
              ),
            ),
            SizedBox(height: 20),
            // Loading Indicator
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white), // White loading indicator
                strokeWidth: 5,
              ),
            ),
            SizedBox(height: 20),
            // Loading Text in Khmer
            Text(
              'កំពុងផ្ទុកកម្មវិធី...', // Loading app... in Khmer
              style: TextStyle(
                fontSize: 18,
                color: Colors.white70, // Slightly transparent white
                fontFamily: 'Noto Sans Khmer', // Apply Khmer font
              ),
            ),
          ],
        ),
      ),
    );
  }
}