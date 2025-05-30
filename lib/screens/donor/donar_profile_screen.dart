import 'package:flutter/material.dart';
import 'doner_home_page.dart';       // Import home screen
import 'donation_screen.dart';        // Import donation screen
import 'donar_notification_screen.dart';    // Import notification screen

class DonorProfileScreen extends StatefulWidget {
  const DonorProfileScreen({super.key});

  @override
  _DonorProfilePageState createState() => _DonorProfilePageState();
}

class _DonorProfilePageState extends State<DonorProfileScreen> {
  bool _isEditing = false;

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  String donorLogoAsset = 'assets/images/donor_profile.jpg';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Donor name');
    _emailController = TextEditingController(text: 'donor@example.com');
    _phoneController = TextEditingController(text: '+1234567890');
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _changeProfileImage() {
    if (!_isEditing) return;
    setState(() {
      donorLogoAsset = donorLogoAsset == 'assets/images/donor_profile.jpg'
          ? 'assets/images/donor_profile_alt.jpg'
          : 'assets/images/donor_profile.jpg';
    });
  }

  void _toggleEdit() {
    if (_isEditing) {
      // Save the profile info
      print('Saving profile info...');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Profile saved')),
      );
      _passwordController.clear();
    }
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  Widget _buildReadOnlyProfile() {
    return Row(
      children: [
        CircleAvatar(
          radius: 50,
          backgroundImage: AssetImage(donorLogoAsset),
        ),
        SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_nameController.text,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
              SizedBox(height: 6),
              Text(_emailController.text,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700])),
              SizedBox(height: 6),
              Text(_phoneController.text,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700])),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildEditProfile() {
    return Column(
      children: [
        GestureDetector(
          onTap: _changeProfileImage,
          child: CircleAvatar(
            radius: 50,
            backgroundImage: AssetImage(donorLogoAsset),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: _nameController,
          decoration: InputDecoration(labelText: 'Name'),
        ),
        SizedBox(height: 12),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        SizedBox(height: 12),
        TextField(
          controller: _phoneController,
          decoration: InputDecoration(labelText: 'Phone Number'),
          keyboardType: TextInputType.phone,
        ),
        SizedBox(height: 12),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(labelText: 'Change Password'),
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildOptionList() {
    return Column(
      children: [
        Divider(height: 40),
        _buildListItem(Icons.collections, 'My Collection', () {}),
        _buildListItem(Icons.timer, 'Donation reminder', () {}),
        _buildListItem(Icons.lock, 'Change password', () {}),
        _buildListItem(Icons.settings, 'Settings', () {}),
      ],
    );
  }

  Widget _buildListItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title),
      trailing: Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account'),
        backgroundColor: Colors.red,
        // No leading: back button removed
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _isEditing ? _buildEditProfile() : _buildReadOnlyProfile(),
              SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                onPressed: _toggleEdit,
                child: Text(_isEditing ? 'Save Profile' : 'Edit Profile'),
              ),
              if (!_isEditing) _buildOptionList(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _buildBottomNavBar(context),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: Colors.red,
      unselectedItemColor: Colors.grey,
      currentIndex: 3, // Profile tab index
      onTap: (index) {
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DonerHomePage()),
            );
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
            // Current page, do nothing
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
