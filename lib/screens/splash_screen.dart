// lib/screens/splash_screen.dart
import 'package:flutter/material.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 255, 252, 252),
      body: Center(
        child: Image.asset('assets/images/logo.png', height: 200),
      ),
    );
  }
}
