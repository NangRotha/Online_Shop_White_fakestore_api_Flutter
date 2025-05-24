import 'package:flutter/material.dart';
import 'login_page.dart';
import 'main_screen.dart';
import '../models/user.dart';

class ProfilePage extends StatelessWidget {
  final User? loggedInUser;

  const ProfilePage({super.key, required this.loggedInUser});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ប្រវត្តិរូបរបស់ខ្ញុំ', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // My Profile
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const CircleAvatar(
              radius: 60,
              backgroundColor: Colors.blueAccent,
              child: Icon(
                Icons.person,
                size: 80,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              loggedInUser != null
                  ? 'សូមស្វាគមន៍, ${loggedInUser!.firstName} ${loggedInUser!.lastName}!' // Welcome, [First Name] [Last Name]!
                  : 'សូមស្វាគមន៍!', // Welcome!
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Colors.blueGrey[800],
                    fontFamily: 'Noto Sans Khmer',
                  ),
              textAlign: TextAlign.center,
            ),
            Text(
              loggedInUser != null ? '@${loggedInUser!.username}' : '',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.grey[600],
                    fontFamily: 'Noto Sans Khmer',
                  ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.email, color: Colors.blueAccent),
                      title: const Text('អាសយដ្ឋានអ៊ីមែល', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Email Address
                      subtitle: Text(loggedInUser?.email ?? 'N/A', style: const TextStyle(fontFamily: 'Noto Sans Khmer')),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('កែប្រែអ៊ីមែល (មុខងារមិនទាន់អនុវត្ត)', style: TextStyle(fontFamily: 'Noto Sans Khmer'))), // Edit email (not implemented)
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.phone, color: Colors.blueAccent),
                      title: const Text('លេខទូរស័ព្ទ', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Phone Number
                      subtitle: Text(loggedInUser?.phone ?? 'N/A', style: const TextStyle(fontFamily: 'Noto Sans Khmer')),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('កែប្រែលេខទូរស័ព្ទ (មុខងារមិនទាន់អនុវត្ត)', style: TextStyle(fontFamily: 'Noto Sans Khmer'))), // Edit phone (not implemented)
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.blueAccent),
                      title: const Text('អាសយដ្ឋានដឹកជញ្ជូន', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Delivery Address
                      subtitle: Text(
                        loggedInUser != null
                            ? '${loggedInUser!.streetNumber} ${loggedInUser!.street}, ${loggedInUser!.city}, ${loggedInUser!.zipcode}'
                            : 'N/A',
                        style: const TextStyle(fontFamily: 'Noto Sans Khmer'),
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('កែប្រែអាសយដ្ឋាន (មុខងារមិនទាន់អនុវត្ត)', style: TextStyle(fontFamily: 'Noto Sans Khmer'))), // Edit address (not implemented)
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              margin: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    ListTile(
                      leading: const Icon(Icons.settings, color: Colors.blueAccent),
                      title: const Text('ការកំណត់', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Settings
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ការកំណត់ (មុខងារមិនទាន់អនុវត្ត)', style: TextStyle(fontFamily: 'Noto Sans Khmer'))), // Settings (not implemented)
                        );
                      },
                    ),
                    const Divider(),
                    ListTile(
                      leading: const Icon(Icons.help_outline, color: Colors.blueAccent),
                      title: const Text('ជំនួយ និងការគាំទ្រ', style: TextStyle(fontFamily: 'Noto Sans Khmer')), // Help & Support
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('ជំនួយ (មុខងារមិនទាន់អនុវត្ត)', style: TextStyle(fontFamily: 'Noto Sans Khmer'))), // Help (not implemented)
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  context.findAncestorStateOfType<MainScreenState>()?.clearLikedProducts();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginPage()),
                  );
                },
                icon: const Icon(Icons.logout),
                label: const Text('ចាកចេញ', style: TextStyle(fontSize: 18, fontFamily: 'Noto Sans Khmer')), // Logout
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}