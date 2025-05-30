import 'package:flutter/material.dart';
import 'donar_notification_screen.dart';
import 'donar_profile_screen.dart';    // DonorProfileScreen
import 'donation_screen.dart';          // DonationPage
import 'donation_details_screen.dart';  // DonationDetailsPage

class DonerHomePage extends StatelessWidget {
  const DonerHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: AppBar(
          backgroundColor: Colors.red,
          centerTitle: false,
          title: Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Text(
              'NOURISH',
              style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(top: 20, right: 12),
              child: GestureDetector(
                onTap: () {
                  // Navigate to profile screen on tap of profile photo
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => DonorProfileScreen()),
                  );
                },
                child: CircleAvatar(
                  radius: 24,
                  backgroundImage: AssetImage('assets/images/pravin.jpg'),
                  
                ),
              ),
            ),
          ],
          leading: null, // This removes the back arrow
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSpotlightSection(context),
            SizedBox(height: 16),
            _buildBecomeDonorSection(),
            SizedBox(height: 16),
            _buildDonationRequestList(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildSpotlightSection(BuildContext context) {
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
                      value: 0.25,
                      backgroundColor: Colors.grey[300],
                      color: Colors.green,
                      minHeight: 8,
                    ),
                    SizedBox(height: 12),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => DonationDetailsPage()),
                        );
                      },
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: Text(
                        'Donate Now',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 1,
                child: Image.asset(
                  'assets/images/donation.png',
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

  Widget _buildDonationRequestList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Donation Request', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        SizedBox(height: 12),
        _buildRequestCard(
          'Share Your Food, Share Your Love',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'assets/images/hungry2.jpg',
        ),
        SizedBox(height: 12),
        _buildRequestCard(
          'Share Your Food, Share Your Love',
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
          'assets/images/hungry1.jpg',
        ),
      ],
    );
  }

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

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      currentIndex: 0,
      onTap: (index) {
        switch (index) {
          case 0:
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DonationPage()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => NotificationScreen()),
            );
            break;
          case 3:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DonorProfileScreen()),
            );
            break;
        }
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.food_bank), label: 'Donate'),
        BottomNavigationBarItem(icon: Icon(Icons.notifications), label: 'Notifications'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
    );
  }
}
