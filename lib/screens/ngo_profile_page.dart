
class _NgoProfilePageState extends State<NgoProfilePage> {
  bool _isEditing = false;
  int _selectedIndex = 3; //Profile tab

  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;
  late TextEditingController _passwordController;

  String ngoLogoAsset = 'assets/ngo_logo.png';

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


