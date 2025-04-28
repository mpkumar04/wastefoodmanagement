// lib/screens/onboarding_screen.dart
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  bool onLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView(
            controller: _controller,
            onPageChanged: (index) {
              setState(() {
                onLastPage = (index == 2);
              });
            },
            children: [
              onboardingPage(
                "assets/images/food_waste.jpeg",
                "No Food Waste",
                "Reduce food waste, save resources, nourish communities.",
              ),
              onboardingPage(
                "assets/images/child_africa.jpeg",
                "We’re in it together",
                "Every meal effort counts.",
              ),
              onboardingPage(
                "assets/images/veggies.jpeg",
                "Just one step",
                "Make a difference today.",
              ),
            ],
          ),
          Container(
            alignment: Alignment(0, 0.75),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextButton(
                  onPressed: () => _controller.jumpToPage(2),
                  child: Text(
                    "Skip",
                    style: TextStyle(color: Colors.white), // 👈 Updated
                  ),
                ),
                SmoothPageIndicator(controller: _controller, count: 3),
                TextButton(
                  onPressed: () {
                    if (onLastPage) {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WelcomeScreen(),
                        ),
                      );
                    } else {
                      _controller.nextPage(
                        duration: Duration(milliseconds: 500),
                        curve: Curves.easeIn,
                      );
                    }
                  },
                  child: Text(
                    onLastPage ? "Done" : "Next",
                    style: TextStyle(color: Colors.white), // 👈 Updated
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget onboardingPage(String image, String title, String description) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(image),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        alignment: Alignment.bottomLeft,
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: [Colors.black87, Colors.transparent],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start, // Left align the text
          children: [
            Text(
              title,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            Text(
              description,
              textAlign: TextAlign.left,
              style: TextStyle(
                fontSize: 16,
                color: Colors.white70,
              ),
            ),
            SizedBox(height: 120),
          ],
        ),
      ),
    );
  }
}
