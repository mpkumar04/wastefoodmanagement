import 'package:flutter/material.dart';
import 'ngo_home_screen.dart';
import 'ngo_donation_map_screen.dart';
import 'ngo_profile_page.dart'; // ✅ Import profile page
import 'ngo_notification_page.dart';

class NgoNotificationPage extends StatefulWidget {
  const NgoNotificationPage({super.key});

  @override
  State<NgoNotificationPage> createState() => _NgoNotificationPageState();
}
int _selectedIndex = 2; // Notification tab

void _onItemTapped(int index) {
  if (index == _selectedIndex) return;

  switch (index) {
    case 0:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NgoHomeScreen()),
      );
      break;
    case 1:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NgoDonationPage()),
      );
      break;
    case 2:
      // Already on Notifications
      break;
    case 3:
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const NgoProfilePage()), // ✅ Navigate to Profile
      );
      break;
  }

  setState(() {
    _selectedIndex = index;
  });
}
final List<Map<String, String>> notifications = [
  {
    'title': 'Donation has been sent to Social Project.',
    'subtitle': 'Thank you for your contribution to our community.',
    'date': '6 Apr 2024',
  },
  {
    'title': 'New Food Donation Request',
    'subtitle': 'Urgent need for meals in local area.',
    'date': '5 Apr 2024',
  },
];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => const Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: const Icon(Icons.notifications, color: Colors.red),
            title: Text(notification['title']!),
            subtitle: Text(notification['subtitle']!),
            trailing: Text(notification['date']!),
          );
        },
      ),

