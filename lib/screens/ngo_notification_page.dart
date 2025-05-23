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

