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

