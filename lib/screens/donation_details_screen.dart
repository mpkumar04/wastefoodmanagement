import 'package:flutter/material.dart';

class DonationDetailsPage extends StatelessWidget {
  const DonationDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text("Details"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/biriyani.jpg',
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            Text(
              'Biriyani',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '20h to go',
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8),

            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 20),
                SizedBox(width: 5),
                Text(
                  'Colombo',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 20),
                Icon(Icons.attach_money, color: Colors.green, size: 20),
                SizedBox(width: 5),
                Text(
                  '500',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),

            SizedBox(height: 16),

            // Placeholder for button
            Center(
              child: ElevatedButton(
                onPressed: () {},
                child: Text('Donate Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
