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

