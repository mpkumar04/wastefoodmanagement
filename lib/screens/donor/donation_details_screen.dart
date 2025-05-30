import 'package:flutter/material.dart';
import 'doner_home_page.dart';  // Import home screen to navigate back

class DonationDetailsPage extends StatelessWidget {
  const DonationDetailsPage({super.key});

  void _showSuccessAndNavigateBack(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Thank you for your donation!'),
        duration: Duration(seconds: 1),
      ),
    );

    Future.delayed(Duration(seconds: 1), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (context) => DonerHomePage()),
        (route) => false,
      );
    });
  }

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
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black),
            ),
            SizedBox(height: 4),
            Text(
              '20h to go',
              style: TextStyle(color: Colors.grey[600]),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.location_on, color: Colors.red, size: 20),
                SizedBox(width: 5),
                Text('Colombo', style: TextStyle(fontWeight: FontWeight.w500)),
                SizedBox(width: 20),
                Icon(Icons.attach_money, color: Colors.green, size: 20),
                SizedBox(width: 5),
                Text('500', style: TextStyle(fontWeight: FontWeight.w500)),
              ],
            ),
            SizedBox(height: 16),
            Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut augue amet vel odio. It is a long description to show the details of the donation, including quantity and other necessary details.',
              style: TextStyle(color: Colors.grey[700], height: 1.5),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel'),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      _showSuccessAndNavigateBack(context);
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: Text('Donate Now'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
