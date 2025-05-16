import 'package:flutter/material.dart';

class DonerHomePage extends StatelessWidget {
  const DonerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy spotlight and donation request data
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('NOURISH - DONER'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSpotlightCard(),
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

  // Updated spotlight card
  Widget _buildSpotlightCard() {
    return Container(
      height: 180,
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.pink[100],
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Text(
                  'Help families in village by donating food',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
              Icon(Icons.food_bank, size: 50, color: Colors.redAccent),
            ],
          ),
          SizedBox(height: 10),
          Text('25% funds collected - 20 days left', style: TextStyle(fontSize: 12)),
          SizedBox(height: 12),
          LinearProgressIndicator(
            value: 0.25,
            backgroundColor: Colors.grey[300],
            color: Colors.green,
            minHeight: 8,
          ),
          SizedBox(height: 12),
          ElevatedButton(
            onPressed: () {},
            child: Text('Donate Now'),
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          ),
        ],
      ),
    );
  }

  // "Become a Food Donor Today" section
  Widget _buildBecomeDonorSection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildIconButton('Donate Food', Icons.food_bank),
        _buildIconButton('NGO Agent', Icons.group),
        _buildIconButton('Request Food', Icons.fastfood),
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

  // Donation Request list with images
  Widget _buildDonationRequestList() {
    // Dummy data - replace with dynamic data
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Donation Request', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 12),
        _buildRequestCard(
          'Share Your Food, Share Your Love',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'assets/donation1.jpg',
        ),
        SizedBox(height: 12),
        _buildRequestCard(
          'Share Your Food, Share Your Love',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'assets/donation2.jpg',
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
            child: Image.asset(imagePath, width: 100, height: 80, fit: BoxFit.cover),
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
