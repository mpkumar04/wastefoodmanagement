
import 'package:flutter/material.dart';

class DonerHomePage extends StatelessWidget {
  const DonerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Increase the AppBar height here
        child: AppBar(
          backgroundColor: Colors.red,
          centerTitle: false,  // Disable centerTitle
          title: Padding(
            padding: const EdgeInsets.only(top: 20), // Adjust top margin for title
            child: Text(
              'NOURISH',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 12), // Adjust top margin for profile
              child: CircleAvatar(
                radius: 50, // Set the profile circle size to 50 (increased size)
                backgroundImage: AssetImage('assets/images/profile.jpg'), // Change to actual image path
                backgroundColor: Colors.grey[300], // Optional, if no image
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSpotlightSection(),
            SizedBox(height: 16),
            _buildBecomeDonorSection(),
            SizedBox(height: 16),
            _buildDonationRequestList(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(),
    );
  }

  // Spotlight section with heading, scrollable content, and image on the side
  Widget _buildSpotlightSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Spotlight', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
        SizedBox(height: 8),
        Container(
          padding: EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Colors.pink[100],
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              // Column for Text, Progress Bar, and Button
              Expanded(
                flex: 2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Help families in village by donating food',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    SizedBox(height: 10),
                    Text('25% funds collected - 20 days left', style: TextStyle(fontSize: 12)),
                    SizedBox(height: 12),
                    LinearProgressIndicator(
                      value: 0.1,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                      minHeight: 8,
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(
                        'Donate Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              // Image on the right side
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/donation.png', // Ensure this image exists
                  width: 100,
                  height: 100,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // "Become a Food Donor Today" section with 3 icons
  Widget _buildBecomeDonorSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIconButton('Donate Food', Icons.food_bank),
        _buildIconButton('NGO Agent', Icons.group),
        _buildIconButton('Food Request', Icons.fastfood),
      ],
    );
  }

  // Icon buttons in "Become a Food Donor Today"
  Widget _buildIconButton(String label, IconData icon) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.red[100],
          child: Icon(icon, color: Colors.red, size: 28),
        ),
        SizedBox(height: 8),
        Text(label, style: TextStyle(fontWeight: FontWeight.w600)),
      ],
    );
  }

  // Donation Request section
  Widget _buildDonationRequestList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Donation Request', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 12),
        _buildRequestCard(
          'Share Your Food, Share Your Love',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'assets/images/hungry2.jpg', // Add actual image here
        ),
        SizedBox(height: 12),
        _buildRequestCard(
          'Share Your Food, Share Your Love',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'assets/images/hungry1.jpg', // Add actual image here
        ),
      ],
    );
  }

  // Request card for donation requests
  Widget _buildRequestCard(String title, String description, String imagePath) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.horizontal(left: Radius.circular(12)),
            child: Image.asset(imagePath, width: 150, height: 120, fit: BoxFit.cover),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 6),
                  Text(description, maxLines: 2, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // Bottom navigation bar
  Widget _buildBottomNavBar() {
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      onTap: (index) {
        // TODO: Navigate between tabs
      },
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Donate'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
