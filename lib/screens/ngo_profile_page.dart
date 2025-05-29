


import 'package:flutter/material.dart';
import 'ngo_home_screen.dart';
import 'ngo_donation_map_screen.dart';
import 'ngo_notification_page.dart';
import 'ngo_profile_page.dart';

class NgoProfilePage extends StatefulWidget {
  const NgoProfilePage({super.key});

  @override
  _NgoProfilePageState createState() => _NgoProfilePageState();
}
class _NgoProfilePageState extends State<NgoProfilePage> {
  bool _isEditing = false;
  int _selectedIndex = 3; //Profile tab

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


