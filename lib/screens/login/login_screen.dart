import 'package:flutter/material.dart';
import 'package:wastefoodmanagement/authmanagement/auth_management.dart';
import 'donor_signup_screen.dart'; // For navigating to role selection
import 'package:wastefoodmanagement/screens/ngo/ngo_home_screen.dart';
import 'package:wastefoodmanagement/screens/donor/doner_home_page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final AuthService _authService = AuthService();
  bool isloading = false;


  void login() async {
  setState(() {
    isloading = true; // Start loading
  });

  // Validate form before continuing
  if (!_formKey.currentState!.validate()) {
    setState(() {
      isloading = false; // Stop loading if form is invalid
    });
    return;
  }

  String email = emailController.text.trim();
  String password = passwordController.text.trim();

  // Null check for email and password fields
  if (email.isEmpty || password.isEmpty) {
    setState(() {
      isloading = false; // Stop loading
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Email and Password cannot be empty')),
    );
    return;
  }

  try {
    // Perform login with AuthService
    String? result = await _authService.login(
      email: email,
      password: password,
    );

    setState(() {
      isloading = false; // Stop loading after login attempt
    });

    // Debugging: print the result from login
    print("Login result: $result");

    // Check the result (user role)
    if (result == "ngo") {
      // If role is "ngo", navigate to NGO Home Screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const NgoHomeScreen(),
        ),
      );
    } else if (result == "donor") {
      // If role is "donor", navigate to Donor Dashboard (Home Page)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => const DonerHomePage(), // Navigate to Donor Home Page (Dashboard)
        ),
      );
    } else {
      // If result is invalid, show an error message
      print("Invalid credentials or role: $result");  // Debugging print
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Invalid credentials or role: $result')),
      );
    }
  } catch (e) {
    setState(() {
      isloading = false; // Stop loading if there's an error
    });

    // Catch any exception and show an error message
    print("Login error: $e");  // Debugging print
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Login failed: $e')),
    );
  }
}


  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: ListView(
          children: [
            Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); // Go back to previous screen
                  },
                ),
              ],
            ),
            const SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/login.png',
                height: 120,
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Login to your account",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ),
            const SizedBox(height: 30),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  buildTextField("Email", controller: emailController, icon: Icons.email),
                  const SizedBox(height: 30),
                  buildTextField("Password", controller: passwordController, icon: Icons.lock, obscureText: true),
                ],
              ),
            ),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Logic for forgot password screen
                },
                child: const Text(
                  "Forgot your password?",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),

            isloading ?
            const Center(
              child: CircularProgressIndicator(),
            ) :
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed:(){
                if (_formKey.currentState!.validate()) {
                  login();  // Proceed with login if form is valid
                } else {
                  // Form is invalid, show an error or handle accordingly
                  print("Form is invalid!");
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Set the background color
                minimumSize: const Size(double.infinity, 50), // Set the minimum size of the button
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                ),
              ),
              child: const Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 18), // Set the text style
              ),
            ),

            const SizedBox(height: 20),
            
            const SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const DonorSignupScreen()),
                      );
                    },
                    child: const Text(
                      "Register here",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTextField(String label, {bool obscureText = false, required TextEditingController controller, required IconData icon}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "$label is required";
        }
        return null;
      },
    );
  }
}

