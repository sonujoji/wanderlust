import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:wanderlust/widgets/feature/signup_widgets.dart';
import 'package:wanderlust/service/signup_service.dart';
import 'package:wanderlust/widgets/feature/bottom_navbar/bottom_navbar.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/models/user.dart';
import 'package:wanderlust/screens/auth_screens/signup_screen.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

Future<void> setLoginState(bool isLoggedIn) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.setBool('isLoggedIn', isLoggedIn);
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController usernameControllerLogin = TextEditingController();
  TextEditingController passwordControllerLogin = TextEditingController();
  final GlobalKey<FormState> _formkeyTwo = GlobalKey<FormState>();
  UserService userService = UserService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: primaryColor,
        body: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.1, vertical: screenHeight * 0.1),
          child: Form(
            key: _formkeyTwo,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Lottie.asset('assets/images/loginanimation.json'),
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      fontSize: 34,
                      color: Colors.white,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  UsernameTextfield(
                    usernameController: usernameControllerLogin,
                  ),
                  SizedBox(
                    height: screenHeight * 0.013,
                  ),
                  PasswordTextfield(
                    passwordController: passwordControllerLogin,
                  ),
                  SizedBox(
                    height: screenHeight * 0.02,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 110, vertical: 7)),
                    onPressed: () {
                      if (_formkeyTwo.currentState!.validate()) {
                        checkUserLogedin();
                      }
                    },
                    child: const Text(
                      'Log in',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New User?',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const SignUpScreen()));
                        },
                        child: const Text(
                          'Register Here',
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
        ));
  }

  Future<void> setLoginUserDetails(User loggedInUser) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInUsername', loggedInUser.username);
  }

  Future<void> checkUserLogedin() async {
    List<User> users = await userService.getUserData();
    setState(() {});

    for (var user in users) {
      log(user.username);
      if (user.username == usernameControllerLogin.text.trim() &&
          user.password == passwordControllerLogin.text.trim()) {
        await setLoginState(true);
        await setLoginUserDetails(user);
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomeScreen()));
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Login Succesfull'),
          backgroundColor: Colors.blue,
        ));
        break;
      }
      // else {
      //   ScaffoldMessenger.of(context).showSnackBar(
      //       const SnackBar(content: Text('Username & Password doesnt exist')));
      // }
    }
  }
}
