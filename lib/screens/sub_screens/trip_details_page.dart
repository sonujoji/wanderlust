import 'package:flutter/material.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/screens/sub_screens/budget_page.dart';
import 'package:wanderlust/screens/sub_screens/documents_page.dart';
import 'package:wanderlust/screens/sub_screens/itenarary_page.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class TripDetailsScreen extends StatefulWidget {
  final Trip trip;
  const TripDetailsScreen({super.key, required this.trip});

  @override
  State<TripDetailsScreen> createState() => _TripDetailsScreenState();
}

class _TripDetailsScreenState extends State<TripDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        backgroundColor: primaryColor,
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: CustomText(
            text: widget.trip.title,
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
              Tab(text: 'Documents'),
            ],
          ),
        ),
        body: TabBarView(children: [
          ItenararyPage(trip: widget.trip),
          BudgetPage(
            trip: widget.trip,
          ),
          DocumentsPage(
            tripId: widget.trip.id.toString(),
          )
        ]),
      ),
    );
  }
}
