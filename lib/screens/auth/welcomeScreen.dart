import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wanderlust/screens/auth/login_screen.dart';
import 'package:wanderlust/utils/colors.dart';

import 'package:wanderlust/screens/auth/signup_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
        child: Center(
          child: Column(
            children: [
              SizedBox(
                height: screenHeight * 0.1,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      'assets/images/wanderlustLogo.jpg',
                      height: 40,
                      width: 40,
                    ),
                  ),
                  SizedBox(width: screenWidth * 0.05),
                  const Text(
                    'Wanderlust',
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),
              Lottie.asset('assets/images/welcomeLottie.json'),
              SizedBox(height: screenHeight * 0.02),
              const Text(
                'Explore Beyond\nBoundaries. Start\nYour Adventure\nToday.',
                style: TextStyle(
                    fontSize: 34,
                    fontWeight: FontWeight.w500,
                    color: Colors.white),
              ),
              SizedBox(height: screenHeight * 0.03),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 80, vertical: 7)),
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                      MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: const Text(
                  'Get Started ',
                  style: const TextStyle(color: Colors.white, fontSize: 24),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Already a Member,',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                          builder: (context) => LogInScreen()));
                    },
                    child: const Text(
                      'Log In',
                      style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                          fontSize: 16),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
