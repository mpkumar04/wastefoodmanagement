import 'package:flutter/material.dart';
import 'ngo_home_screen.dart';
import 'ngo_donation_map_screen.dart';
import 'ngo_notification_page.dart';

class NgoProfilePage extends StatefulWidget {
  const NgoProfilePage({super.key});

  @override
  _NgoProfilePageState createState() => _NgoProfilePageState();
}

class _NgoProfilePageState extends State<NgoProfilePage> {
  bool _isEditing = false;
  int _selectedIndex = 3; // Profile tab

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  String ngoLogoAsset = 'assets/ngo_logo.png';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: 'Ngo Name');
    _emailController = TextEditingController(text: 'ngo@gmail.com');
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

  void _onItemTapped(int index) {
    if (index == _selectedIndex) return;

    switch (index) {
      case 0:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NgoHomeScreen()),
        );
        break;
      case 1:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NgoDonationPage()),
        );
        break;
      case 2:
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const NgoNotificationPage()),
        );
        break;
      case 3:
        // Already on Profile
        break;
    }

    setState(() {
      _selectedIndex = index;
    });
  }

  void _changeProfileImage() {
    if (!_isEditing) return;
    setState(() {
      ngoLogoAsset = ngoLogoAsset == 'assets/ngo_logo.png'
          ? 'assets/ngo_logo_alt.png'
          : 'assets/ngo_logo.png';
    });
  }

  void _toggleEdit() {
    if (_isEditing) {
      print('Saving profile info...');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Profile saved')),
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
          backgroundImage: AssetImage(ngoLogoAsset),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(_nameController.text,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 26)),
              const SizedBox(height: 6),
              Text(_emailController.text,
                  style: TextStyle(fontSize: 18, color: Colors.grey[700])),
              const SizedBox(height: 6),
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
            backgroundImage: AssetImage(ngoLogoAsset),
          ),
        ),
        const SizedBox(height: 20),
        TextField(
          controller: _nameController,
          decoration: const InputDecoration(labelText: 'Name'),
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _emailController,
          decoration: const InputDecoration(labelText: 'Email'),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _phoneController,
          decoration: const InputDecoration(labelText: 'Phone Number'),
          keyboardType: TextInputType.phone,
        ),
        const SizedBox(height: 12),
        TextField(
          controller: _passwordController,
          decoration: const InputDecoration(labelText: 'Change Password'),
          obscureText: true,
        ),
      ],
    );
  }

  Widget _buildOptionList() {
    return Column(
      children: [
        const Divider(height: 40),
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
      trailing: const Icon(Icons.arrow_forward_ios),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Account'),
        backgroundColor: Colors.red,
        automaticallyImplyLeading: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _isEditing ? _buildEditProfile() : _buildReadOnlyProfile(),
              const SizedBox(height: 30),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: const Size(double.infinity, 50),
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
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.red,
        unselectedItemColor: Colors.black54,
        onTap: _onItemTapped,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.map), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
        ],
      ),
    );
  }
}
