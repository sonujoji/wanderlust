import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/widgets/feature/trip_details_widget/add_trip.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:wanderlust/widgets/feature/trip_details_widget/delete_trip_dialogue.dart';
import 'package:wanderlust/widgets/feature/trip_details_widget/edit_trip_dialogue.dart';
import 'package:wanderlust/widgets/feature/trip_details_widget/upcoming_trips.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';
import 'package:wanderlust/widgets/global/empty_dialogue.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  late TextEditingController placeController;
  late TextEditingController countryController;
  late TextEditingController descriptionController;
  late TextEditingController travellorsController;
  late TextEditingController budgetController;

  final TripService _tripService = TripService();
  File? updatedImage;
  @override
  void initState() {
    super.initState();
    placeController = TextEditingController();
    countryController = TextEditingController();
    descriptionController = TextEditingController();
    travellorsController = TextEditingController();
    budgetController = TextEditingController();
    _tripService.getTripDetails();
  }

  @override
  void dispose() {
    placeController.dispose();
    countryController.dispose();
    descriptionController.dispose();
    travellorsController.dispose();
    budgetController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double screenHeight = MediaQuery.of(context).size.height;
    // double screenWidth = MediaQuery.of(context).size.width;
    return ValueListenableBuilder(
      valueListenable: tripListNotifier,
      builder: (BuildContext cxt, List<Trip> trips, Widget? child) {
        return Scaffold(
          backgroundColor: primaryColor,
          appBar: AppBar(
            backgroundColor: primaryColor,
            title: const Text(
              'Your Trips',
              style: TextStyle(
                fontSize: 30,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            centerTitle: true,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const AddTripPage()));
            },
            backgroundColor: Colors.blue,
            child: const Icon(
              Icons.add,
            ),
          ),
          body: trips.isEmpty
              ? const EmptyDialogue(
                  imagePath: 'assets/images/Journey-amico.png',
                  text: "You haven't added any trips")
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const CustomText(
                        text: 'Upcoming Trips,',
                        fontSize: 23,
                        fontWeight: FontWeight.w500,
                      ),
                      const SizedBox(height: 10),
                      Expanded(
                        child: ListView.builder(
                          itemCount: trips.length,
                          itemBuilder: (context, index) {
                            final trip = trips[index];
                            return Padding( 
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Slidable(
                                endActionPane: ActionPane(
                                    motion: const StretchMotion(),
                                    children: [
                                      SlidableAction(
                                        onPressed: (context) {
                                          //edit dialogue
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  EditTripDialog(
                                                      trip: trip,
                                                      index: index));
                                        },
                                        backgroundColor: primaryColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          showDialog(
                                              context: context,
                                              builder: (context) =>
                                                  //delete dialogue
                                                  DeleteTripDialogue(
                                                    index: index,
                                                    onDelete: (index) =>
                                                        _tripService
                                                            .deleteTrip(index),
                                                  ));
                                        },
                                        backgroundColor: primaryColor,
                                        foregroundColor: Colors.red,
                                        icon: Icons.delete,
                                      )
                                    ]),
                                child: ListTrips(trip: trip,index: index,),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
        );
      },
    );
  }
}
