import 'package:flutter/material.dart';

class NgoDetailsScreen extends StatelessWidget {
  const NgoDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Image.network('https://via.placeholder.com/300x200'),
            SizedBox(height: 10),
            Text('Biryani', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            SizedBox(height: 5),
            Text('20 Sep 2025'),
            SizedBox(height: 10),
            Text('Freshly cooked Biryani available for donation to needy families. Help us spread smiles.'),
            Spacer(),
            ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Accept'),
            )
          ],
        ),
      ),
    );
  }
}
