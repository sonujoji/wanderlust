import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class TripDetailsScreen extends StatefulWidget {
  const TripDetailsScreen({super.key});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: CustomText(
            text: 'Manali',
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          bottom: TabBar(
            indicatorColor: blue,
            unselectedLabelColor: white,
            labelColor: blue,
            tabs: [
              Tab(text: 'Itenerary'),
              Tab(text: 'Budget'),
            ],
          ),
        ),
        body: TabBarView(children: [
          Center(
            child: CustomText(text: 'Itenerary'),
          ),
          Center(
            child: CustomText(text: 'Budget'),
          ),
        ]),
      ),
    );
  }
}
