import 'package:flutter/material.dart';
import 'doner_home_page.dart';       // Import your home screen
import 'donation_screen.dart';        // Import your donation screen
import 'donar_profile_screen.dart';   // Import your profile screen

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Notification'),
        // No leading/back button here
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildNotificationCard(
              "Donation has been sent to Social Project",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc imperdiet ornare aliquet enim.",
              "5 Apr 2024",
            ),
            _buildNotificationCard(
              "Donation has been sent to Social Project",
              "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nunc imperdiet ornare aliquet enim.",
              "3 Apr 2024",
            ),
            // Add more notifications if necessary
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildNotificationCard(String title, String description, String date) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: EdgeInsets.only(bottom: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(16),
        leading: Icon(
          Icons.notifications,
          color: Colors.red,
        ),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(description),
        trailing: Text(date, style: TextStyle(color: Colors.grey[600])),
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      currentIndex: 2, // Notifications index
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DonerHomePage()),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DonationPage()),
            );
            break;
          case 2:
            // Current page, do nothing
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DonorProfileScreen()),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Donate'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
