// lib/screens/ngo_signup_screen.dart
import 'package:flutter/material.dart';

class NgoSignupScreen extends StatefulWidget {
  const NgoSignupScreen({super.key});

  @override
  State<NgoSignupScreen> createState() => _NgoSignupScreenState();
}

class _NgoSignupScreenState extends State<NgoSignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController ngoNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // tap outside to close keyboard
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 10),
                  Center(
                    child: Image.asset('assets/images/ngo_signup.png', height: 150),
                  ),
                  SizedBox(height: 10),
                  Center(
                    child: Text(
                      "Create your NGO Account",
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Form fields
                  buildTextField(
                    label: "NGO Name",
                    controller: ngoNameController,
                    icon: Icons.business,
                    keyboardType: TextInputType.text,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please enter NGO name";
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  buildTextField(
                    label: "Email",
                    controller: emailController,
                    icon: Icons.email,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please enter email";
                      if (!value.contains("@")) return "Enter a valid email";
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  buildTextField(
                    label: "Phone No",
                    controller: phoneController,
                    icon: Icons.phone,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please enter phone number";
                      if (value.length < 10) return "Enter valid phone number";
                      return null;
                    },
                  ),
                  SizedBox(height: 10),
                  buildTextField(
                    label: "Password",
                    controller: passwordController,
                    icon: Icons.lock,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) return "Please enter password";
                      if (value.length < 6) return "Password must be at least 6 characters";
                      return null;
                    },
                  ),
                  SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        // Signup logic here
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Signup Successful!")),
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
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  SizedBox(height: 20),
                ],
              ),
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
    bool obscureText = false,
    TextInputType keyboardType = TextInputType.text,
    required String? Function(String?) validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator,
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
