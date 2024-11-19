import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/widgets/feature/bottom_navbar/bottom_navbar.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/screens/auth_screens/welcomeScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goToLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final logoSize = screenWidth * 0.25;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/wanderlustLogo.jpg',
            width: logoSize,
            height: logoSize,
          ),
        ),
      ),
    );
  }
  
  // checking the current status
  
  Future<void> goToLogin() async {
    await Future.delayed(const Duration(seconds: 1));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    String isLoggedInString = prefs.getString('isLoggedIn') ?? 'false';
    bool isLoggedIn = isLoggedInString == 'true';

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            isLoggedIn == true ? const HomeScreen() : const WelcomeScreen()));
  }
}
