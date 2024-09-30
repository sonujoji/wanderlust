import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/screens/home/home_screen.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/screens/auth/welcomeScreen.dart';

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
    return Scaffold(
      backgroundColor: primaryColor,
      body: Center(
        child: ClipOval(
          child: Image.asset(
            'assets/images/wanderlustLogo.jpg',
            width: 100,
            height: 100,
          ),
        ),
      ),
    );
  }

  Future<void> goToLogin() async {
    await Future.delayed(const Duration(seconds: 1));

    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isLoggedIn') ?? false;

    Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) =>
            isLoggedIn == true ? const HomeScreen() : const WelcomeScreen()));
  }
}
