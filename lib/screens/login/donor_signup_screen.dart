
import 'package:wastefoodmanagement/authmanagement/auth_management.dart';
import 'package:flutter/material.dart';
import 'welcome_screen.dart';

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
  String selectRole = "Users"; 
  final FocusNode _emailFocus = FocusNode();
  final FocusNode _phoneFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
 // Default selection is 'Donor'

  // Variable for Role Selection
  String? selectedRole = 'Donor'; // Default selection is 'Donor'

  final AuthService _authService = AuthService();
  void signUp() async {
     String? result = await _authService.signUp(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
      name: userNameController.text.trim(),
      phno: phoneController.text.trim(),
      role: selectRole,
     );
    if (result == null) {
      // Sign-up successful
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up successful!')),
      );
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => WelcomeScreen()
        ),
      );
    }else{
        ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Sign up Faild!')));

    }
  }

 


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
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 10),
                Center(
                  child: Image.asset('assets/images/donor_signup.png', height: 150),
                ),
                const SizedBox(height: 10),
                const Center(
                  child: Text(
                    "Create your Donor Account",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                  ),
                ),
                const SizedBox(height: 20),

                
                
                // Text Fields
                buildTextField(
                  label: "User name",
                  controller: userNameController,
                  icon: Icons.person,
                  nextFocus: _emailFocus,
                ),
                const SizedBox(height: 10),
                buildTextField(
                  label: "Email",
                  controller: emailController,
                  icon: Icons.email,
                  focusNode: _emailFocus,
                  nextFocus: _phoneFocus,
                  isEmail: true,
                ),
                const SizedBox(height: 10),
                buildTextField(
                  label: "Phone no",
                  controller: phoneController,
                  icon: Icons.phone,
                  focusNode: _phoneFocus,
                  nextFocus: _passwordFocus,
                  isPhone: true,
                ),
                const SizedBox(height: 10),
                buildTextField(
                  label: "Password",
                  controller: passwordController,
                  icon: Icons.lock,
                  focusNode: _passwordFocus,
                  isPassword: true,
                ),
                const SizedBox(height: 15),
                
                
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: InputDecoration(
                    labelText: "Select Role",
                    prefixIcon: Icon(Icons.account_circle),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  items: ['Donor', 'NGO'].map((role) {
                    return DropdownMenuItem<String>(
                      value: role,
                      child: Text(role),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      selectedRole = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select a role';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 20),


                // Sign Up button
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthService().signUp(
                        email: emailController.text.trim(),
                        password: passwordController.text.trim(),
                        name: userNameController.text.trim(),
                        phno: phoneController.text.trim(),
                        role: selectedRole ?? 'Donor', // Use selectedRole or default to 'Donor'
);
                      // Navigate to WelcomeScreen after successful sign-up
                      Future.delayed(const Duration(seconds: 2), () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => WelcomeScreen()),
                        );
                      });

                      // If all fields are valid
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Sign up successful!')),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: const Text("Sign Up", style: TextStyle(fontSize: 18, color: Colors.white)),
                ),
                const SizedBox(height: 20),
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
