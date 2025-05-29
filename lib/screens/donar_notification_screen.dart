import 'package:flutter/material.dart';

class NotificationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('Notification'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
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

      
      bottomNavigationBar: _buildBottomNavBar(),

  // Notification card widget
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


