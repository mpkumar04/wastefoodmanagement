import 'package:flutter/material.dart';
import 'select_role_screen.dart'; // For navigating to role selection

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _loginSuccessMessage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.all(24),
        child: ListView(
          children: [
            SizedBox(height: 0),
            // Back Button at the top
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    Navigator.pop(context); // This will pop the current screen and go back
                  },
                ),
              ],
            ),
            SizedBox(height: 20),
            Center(
              child: Image.asset(
                'assets/images/login.png',
                height: 120,
              ),
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                "Login to your account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ),
            SizedBox(height: 30),
            // Form for email and password with validation
            Form(
              key: _formKey,
              child: Column(
                children: [
                  SizedBox(height: 20),
                  buildTextField("Email", controller: emailController, icon: Icons.email),
                  SizedBox(height: 30),
                  buildTextField("Password", controller: passwordController, icon: Icons.lock, obscureText: true),
                ],
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  // Add your logic for forgot password screen here
                  // For example, navigating to a password recovery screen:
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(builder: (context) => ForgotPasswordScreen()),
                  // );
                },
                child: Text(
                  "Forgot your password?",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState?.validate() ?? false) {
                  // Simulate a successful login
                  setState(() {
                    _loginSuccessMessage = "Login Successful!";
                  });
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                minimumSize: Size(double.infinity, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                "Login",
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
            SizedBox(height: 20),
            // Show the login success message if successful
            if (_loginSuccessMessage != null)
              Text(
                _loginSuccessMessage!,
                style: TextStyle(color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            SizedBox(height: 20),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account? "),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SelectRoleScreen()),
                      );
                    },
                    child: Text(
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

  Widget buildTextField(String label,
      {bool obscureText = false, required TextEditingController controller, required IconData icon}) {
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
