import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/models/user.dart';
import 'package:wanderlust/screens/auth/splash_screen.dart';
import 'package:wanderlust/service/budget_service.dart';
import 'package:wanderlust/service/doc_service.dart';
import 'package:wanderlust/service/iteneraries_service.dart';
import 'package:wanderlust/service/memories_service.dart';
import 'package:wanderlust/service/signup_service.dart';
import 'package:wanderlust/service/trip_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();

  //register adaptor
  Hive.registerAdapter(UserAdapter());
  Hive.registerAdapter(TripAdapter());
  Hive.registerAdapter(BudgetAdapter());
  Hive.registerAdapter(MemoriesAdapter());
  Hive.registerAdapter(DocumentsAdapter());
  // Hive.registerAdapter(ItenerariesAdapter());

  //open box
  await DocService().openBox();
  await UserService().openBox();
  await BudgetService().openBox();
  await MemoriesService().openBox();
  await TripService().openBox();
  // await ItinerariesService().openBox();

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
