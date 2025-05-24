// lib/pages/register_page.dart
import 'package:flutter/material.dart';
import 'main_screen.dart'; // Import MainScreen
import '../models/user.dart'; // Import User model

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  Future<void> _register(BuildContext context) async {
    String username = _usernameController.text;
    String email = _emailController.text;
    String password = _passwordController.text;

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
            content: Text('សូមបំពេញព័ត៌មានលំអិតនៃការចុះឈ្មោះទាំងអស់។')), // Please fill in all the registration details.
      );
      return;
    }

    // Simulate successful registration
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('ការចុះឈ្មោះបានជោគជ័យ! កំពុងចូលគណនី...'), // Registration successful! Logging you in...
        backgroundColor: Colors.green,
      ),
    );

    // Simulate creating a User object for the registered user
    final simulatedUser = User(
      id: DateTime.now().millisecondsSinceEpoch, // Dummy ID
      username: username,
      email: email,
      firstName: username, // Using username as first name for simplicity
      lastName: '',
      phone: '000000',
      city: 'prey veng',
      street: '012',
      streetNumber: 0,
      zipcode: '123',
    );

    // Navigate to MainScreen with the simulated logged-in user
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MainScreen(loggedInUser: simulatedUser)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100], // Light background
      appBar: AppBar(
        title: const Text(
          'ចុះឈ្មោះ', // Register
          style: TextStyle(fontFamily: 'Noto Sans Khmer'),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 30),
            Icon(
              Icons.person_add_alt_1,
              size: 80,
              color: Colors.blueAccent,
            ),
            const SizedBox(height: 30),
            Text(
              'បង្កើតគណនីថ្មី', // Create new account
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blueGrey[800],
                fontFamily: 'Noto Sans Khmer',
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            // Username
            TextFormField(
              controller: _usernameController,
              style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
              decoration: InputDecoration(
                labelText: 'ឈ្មោះអ្នកប្រើប្រាស់', // Username
                labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                prefixIcon: const Icon(Icons.person_outline),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            // Email
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
              decoration: InputDecoration(
                labelText: 'អ៊ីមែល', // Email
                labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                prefixIcon: const Icon(Icons.email_outlined),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 15),
            // Password
            TextFormField(
              controller: _passwordController,
              obscureText: true,
              style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
              decoration: InputDecoration(
                labelText: 'ពាក្យសម្ងាត់', // Password
                labelStyle: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                prefixIcon: const Icon(Icons.lock_outline),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
            ),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => _register(context),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              ),
              child: const Text(
                'ចុះឈ្មោះ', // Register
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, fontFamily: 'Noto Sans Khmer'),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'មានគណនីរួចហើយ?', // Already have an account?
                  style: TextStyle(fontFamily: 'Noto Sans Khmer'),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Go back to the login page
                  },
                  child: const Text(
                    'ចូល', // Log in
                    style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'Noto Sans Khmer'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}