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
          crossAxisAlignment: CrossAxisAlignment.start, // Align text to left
          children: [
            Image.asset(
              'assets/images/biriyani.jpg',
              width: double.infinity,
              height: 400,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 30),
            Text(
              'Biryani',
              style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 5),
            Text(
              '20 Sep 2025',
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 20),
            Text(
              'Freshly cooked Biryani available for donation to needy families. Help us spread smiles.',
              textAlign: TextAlign.left,
            ),
            SizedBox(height: 100), // Reduced gap instead of Spacer
            SizedBox(
              height:60,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text('Accept',
                 style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
