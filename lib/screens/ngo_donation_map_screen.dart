import 'package:flutter/material.dart';

class NgoDonationMapScreen extends StatelessWidget {
  const NgoDonationMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Map'),
        backgroundColor: Colors.red,
      ),
      body: Column(
        children: [
          Expanded(
            child: Image.network(
              'https://via.placeholder.com/400x300?text=Map',
              fit: BoxFit.cover,
              width: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Find Donors Nearby'),
            ),
          )
        ],
      ),
    );
  }
}
