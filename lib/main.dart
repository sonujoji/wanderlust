import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/models/user.dart';
import 'package:wanderlust/screens/auth/splash_screen.dart';
import 'package:wanderlust/service/signup_service.dart';
import 'package:wanderlust/service/trip_service.dart';

void main() async {
  await Hive.initFlutter();

  //user adaptor
  Hive.registerAdapter(UserAdapter());
  await UserService().openBox();

  //documents adapter
  Hive.registerAdapter(DocumentsAdapter());
  

  //addTrip adaptor
  Hive.registerAdapter(TripAdapter());
  await TripService().openBox();

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
