import 'package:flutter/material.dart';

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

