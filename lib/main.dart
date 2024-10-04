import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wanderlust/models/user.dart';
import 'package:wanderlust/screens/auth/splash_screen.dart';
import 'package:wanderlust/service/signup_service.dart';

void main() async {
  await Hive.initFlutter();

  //user adaptor
  Hive.registerAdapter(UserAdapter());
  await UserService().openBox();

  //addTrip adaptor
  // Hive.registerAdapter(addTripAdapter());
  // await UserService().openBox();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'wanderlust',
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
