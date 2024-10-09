import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/screens/pages/add_screens/add_trip.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:intl/intl.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';
import 'package:wanderlust/widgets/global/empty_dialogue.dart';

class HomepageScreen extends StatefulWidget {
  const HomepageScreen({super.key});

  @override
  State<HomepageScreen> createState() => _HomepageScreenState();
}

class _HomepageScreenState extends State<HomepageScreen> {
  final TripService _tripService = TripService();
  TextEditingController placeController = TextEditingController();
  TextEditingController countryController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController travellorsController = TextEditingController();
  TextEditingController budgetController = TextEditingController();
  @override
  void initState() {
    super.initState();
    _tripService.getTripDetails();
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
                      const Text(
                        'Upcoming Trips,',
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
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
                                            builder: (context) {
                                              return AlertDialog(
                                                backgroundColor: primaryColor,
                                                title: const Text(
                                                  'Edit Trip Details',
                                                  style: TextStyle(
                                                      color: Colors.white),
                                                ),
                                                content: SingleChildScrollView(
                                                  child: Column(
                                                    children: [
                                                      GlobalTextField(
                                                        controller:
                                                            placeController,
                                                        labelText: 'Place',
                                                        prefixIcon: Icons.place,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      GlobalTextField(
                                                        controller:
                                                            countryController,
                                                        labelText: 'Country',
                                                        prefixIcon: Icons.flag,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      GlobalTextField(
                                                        controller:
                                                            descriptionController,
                                                        labelText:
                                                            'Description',
                                                        maxLines: 3,
                                                        prefixIcon:
                                                            Icons.description,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      GlobalTextField(
                                                        controller:
                                                            budgetController,
                                                        labelText: 'Budget',
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        prefixIcon: Icons.money,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      GlobalTextField(
                                                        controller:
                                                            travellorsController,
                                                        labelText:
                                                            'No of Travelers',
                                                        keyboardType:
                                                            TextInputType
                                                                .number,
                                                        prefixIcon: Icons.group,
                                                      ),
                                                      const SizedBox(
                                                          height: 10),
                                                      Container(
                                                        height: 110,
                                                        decoration:
                                                            BoxDecoration(
                                                          color: primaryColor,
                                                          border: Border.all(
                                                              color:
                                                                  Colors.white),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        child:
                                                            // selectedImage != null
                                                            //     ? ClipRRect(
                                                            //         borderRadius: BorderRadius.circular(5),
                                                            //         child: Image.file(
                                                            //           selectedImage!,
                                                            //           fit: BoxFit.cover,
                                                            //         ),
                                                            //       )
                                                            //     :
                                                            const Center(
                                                          child: Icon(
                                                            Icons
                                                                .add_photo_alternate,
                                                            color: Colors.blue,
                                                            size: 40,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Cancel',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.of(context)
                                                          .pop();
                                                    },
                                                    child: const Text(
                                                      'Update Trip',
                                                      style: TextStyle(
                                                          color: Colors.white),
                                                    ),
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        backgroundColor: primaryColor,
                                        foregroundColor: Colors.white,
                                        icon: Icons.edit,
                                      ),
                                      SlidableAction(
                                        onPressed: (context) {
                                          showDialog(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                    backgroundColor:
                                                        const Color.fromARGB(
                                                            255, 49, 52, 73),
                                                    title: const Text(
                                                      'Do you want to delete trip',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 20,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                    ),
                                                    actions: [
                                                      TextButton(
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          },
                                                          child: const Text(
                                                            'Cancel',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                      TextButton(
                                                          onPressed: () async {
                                                            await _tripService
                                                                .deleteTrip(
                                                                    index);
                                                            customSnackBar(
                                                                context,
                                                                'Trip deleted');
                                                            Navigator.pop(
                                                                context);
                                                            await _tripService
                                                                .getTripDetails();
                                                          },
                                                          child: const Text(
                                                            'Ok',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          )),
                                                    ],
                                                  ));
                                        },
                                        backgroundColor: primaryColor,
                                        foregroundColor: Colors.red,
                                        icon: Icons.delete,
                                      )
                                    ]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 64, 66, 86),
                                    borderRadius: BorderRadius.circular(30),
                                  ),
                                  child: Column(
                                    children: [
                                      ClipRRect(
                                        borderRadius: BorderRadius.circular(30),
                                        child: Image.file(
                                          File(trip.destinationImage!),
                                          fit: BoxFit.cover,
                                          height: 180,
                                          width: double.infinity,
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            top: 10,
                                            right: 10,
                                            left: 10,
                                            bottom: 20),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  '📍${trip.title}, Kerala',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  '💸 ₹${trip.budget} ',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Text(
                                                  ' 📅 ${DateFormat('dd-MM-yyyy').format(trip.startDate)} - ${DateFormat('dd-MM-yyyy').format(trip.endDate)}',
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  '👥 ${trip.travellorCount} ',
                                                  style: const TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                              ],
                                            ),
                                            Text(
                                              ' 🗺️ ${trip.description}',
                                              style: const TextStyle(
                                                  fontSize: 14,
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
