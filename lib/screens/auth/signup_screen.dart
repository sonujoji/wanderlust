import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wanderlust/screens/auth/login_screen.dart';
import 'package:wanderlust/screens/auth/auth_widgets/signup_widgets.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/models/user.dart';

import 'package:wanderlust/service/signup_service.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: primaryColor,
      body: Padding(
        padding: EdgeInsets.only(
            left: screenWidth * 0.1,
            right: screenWidth * 0.1,
            top: screenHeight * 0.04),
        child: Center(
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(
                      height: screenHeight * 0.3,
                      child: Lottie.asset('assets/images/signup.json')),
                  const Text(
                    'Let’s Get Started',
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
                    usernameController: _usernameController,
                    
                  ),
                  SizedBox(
                    height: screenHeight * 0.012,
                  ),
                  EmailTextfield(
                    emailController: _emailController,
                  ),
                  SizedBox(
                    height: screenHeight * 0.012,
                  ),
                  PhoneTextfield(
                    phoneController: _phoneController,
                  ),
                  SizedBox(
                    height: screenHeight * 0.012,
                  ),
                  PasswordTextfield(
                    passwordController: _passwordController,
                  ),
                  SizedBox(
                    height: screenHeight * 0.03,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 60, vertical: 7)),
                    onPressed: () {
                      createUserAccount();
                    },
                    child: const Text(
                      'Create Account',
                      style: TextStyle(color: Colors.white, fontSize: 24),
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
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (context) => const LogInScreen()));
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
        ),
      ),
    );
  }

  Future<void> createUserAccount() async {
    if (_formKey.currentState!.validate()) {
      final newUser = User(
        username: _usernameController.text.trim(),
        email: _emailController.text.trim(),
        phone: int.parse(_phoneController.text.trim()),
        password: _passwordController.text.trim(),
      );

      await _userService.addUser(newUser);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LogInScreen()));
    }
  }
}
