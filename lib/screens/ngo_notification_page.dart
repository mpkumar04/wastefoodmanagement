import 'package:flutter/material.dart';

class NgoNotificationPage extends StatelessWidget {
  final List<Map<String, String>> notifications = [
    {
      'title': 'Donation has been sent to Social Project.',
      'subtitle':
          'Lorem ipsum dolor sit amet consectetur. Nunc imperdiet ornare aliquet enim.',
      'date': '6 Apr 2024',
    },
    {
      'title': 'Donation has been sent to Social Project.',
      'subtitle':
          'Lorem ipsum dolor sit amet consectetur. Nunc imperdiet ornare aliquet enim.',
      'date': '6 Apr 2024',
    },
  ];

  // Removed 'const' here
  NgoNotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification'),
        backgroundColor: Colors.red,
        leading: BackButton(),
      ),
      body: ListView.separated(
        itemCount: notifications.length,
        separatorBuilder: (_, __) => Divider(height: 1),
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            leading: Icon(Icons.notifications, color: Colors.red),
            title: Text(notification['title']!),
            subtitle: Text(notification['subtitle']!),
            trailing: Text(notification['date']!),
          );
        },
      ),
    );
  }
}
