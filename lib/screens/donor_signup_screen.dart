// lib/screens/donor_signup_screen.dart
import 'package:flutter/material.dart';

class DonorSignupScreen extends StatefulWidget {
  const DonorSignupScreen({super.key});

  @override
  State<DonorSignupScreen> createState() => _DonorSignupScreenState();
}

class _DonorSignupScreenState extends State<DonorSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 10),
                Center(
                  child: Image.asset('assets/images/donor_signup.png', height: 150),
                ),
                SizedBox(height: 10),
                Center(
                  child: Text(
                    "Create your Donor Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ),
                SizedBox(height: 20),

                // Text Fields
                buildTextField(
                  label: "User name",
                  controller: userNameController,
                  icon: Icons.person,
                  nextFocus: _emailFocus,
                ),
                SizedBox(height: 10),
                buildTextField(
                  label: "Email",
                  controller: emailController,
                  icon: Icons.email,
                  focusNode: _emailFocus,
                  nextFocus: _phoneFocus,
                  isEmail: true,
                ),
                SizedBox(height: 10),
                buildTextField(
                  label: "Phone no",
                  controller: phoneController,
                  icon: Icons.phone,
                  focusNode: _phoneFocus,
                  nextFocus: _passwordFocus,
                  isPhone: true,
                ),
                SizedBox(height: 10),
                buildTextField(
                  label: "Password",
                  controller: passwordController,
                  icon: Icons.lock,
                  focusNode: _passwordFocus,
                  isPassword: true,
                ),
                SizedBox(height: 30),

                // Sign Up button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      // If all fields valid
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Sign up successful!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    FocusNode? focusNode,
    FocusNode? nextFocus,
    bool isEmail = false,
    bool isPhone = false,
    bool isPassword = false,
  }) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      obscureText: isPassword,
      keyboardType: isPhone
          ? TextInputType.phone
          : TextInputType.text,
      textInputAction: nextFocus != null ? TextInputAction.next : TextInputAction.done,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return '$label is required';
        }
        if (isEmail && !value.contains('@')) {
          return 'Enter a valid email address';
        }
        if (isPhone && value.length != 10) {
          return 'Phone number must be 10 digits';
        }
        if (isPassword && value.length < 6) {
          return 'Password must be at least 6 characters';
        }
        return null;
      },
      onFieldSubmitted: (_) {
        if (nextFocus != null) {
          FocusScope.of(context).requestFocus(nextFocus);
        }
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
