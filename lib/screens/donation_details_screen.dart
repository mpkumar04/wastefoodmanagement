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
      body: SingleChildScrollView(  // Wrap the body with SingleChildScrollView to make it scrollable
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Image section
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                'assets/images/biriyani.jpg', // Replace with your actual image
                width: double.infinity,
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16),

            // Title and other information
            Text(
              'Biriyani', // Replace with dynamic title
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            SizedBox(height: 4),
            Text(
              '20h to go', // Replace with dynamic time left
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
                  'Colombo', // Replace with dynamic location
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                SizedBox(width: 20),
                Icon(Icons.attach_money, color: Colors.green, size: 20),
                SizedBox(width: 5),
                Text(
                  '500', // Replace with dynamic price/quantity
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(height: 16),

            // Description text
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut augue amet vel odio. It is a long description to show the details of the donation, including quantity and other necessary details.',
              style: TextStyle(
                color: Colors.grey[700],
                height: 1.5,
              ),
            ),
            SizedBox(height: 16),

            // Social project info
            Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green, size: 20),
                SizedBox(width: 5),
                Text(
                  'Social Project',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  'Verified Account',
                  style: TextStyle(color: Colors.green, fontSize: 14),
                ),
              ],
            ),
            SizedBox(height: 20),

            // Donate button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Add your donation functionality here
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red, // Button color
                  padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  'Donate Now',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
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
