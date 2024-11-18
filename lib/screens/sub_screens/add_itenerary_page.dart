import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';

class AddIteneraryPage extends StatefulWidget {
  final Trip trip;

  const AddIteneraryPage({
    super.key,
    required this.trip,
  });

  @override
  State<AddIteneraryPage> createState() => _AddIteneraryPageState();
}

class _AddIteneraryPageState extends State<AddIteneraryPage> {
  final TripService _tripService = TripService();
  TextEditingController locationController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  @override
  void initState() {
    dateController = TextEditingController();
    locationController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    dateController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      appBar: AppBar(
        backgroundColor: primaryColor,
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            )),
        title: CustomText(
          text: 'Create Itinerary',
          fontSize: 20,
          fontWeight: FontWeight.w500,
        ),
        actions: [
          TextButton(
            onPressed: () {
              try {
                if (locationController.text.isNotEmpty &&
                    dateController.text.isNotEmpty) {
                  String date = dateController.text;
                  String location = locationController.text;

                  widget.trip.iteneraries ??= {};

                  if (widget.trip.iteneraries![date] != null) {
                    widget.trip.iteneraries![date]!.add(location);
                  } else {
                    widget.trip.iteneraries![date] = [location];
                  }

                  _tripService.updateItinerary(widget.trip.id!, widget.trip);

                  log('Updated Itineraries: ${widget.trip.iteneraries}');
                  Navigator.pop(context);
                } else {
                  customSnackBar(context, 'Please fill in all fields');
                }
              } catch (e) {
                log('Error while creating travel itinerary: $e');
              }
            },
            style: TextButton.styleFrom(backgroundColor: Colors.blue),
            child: const Text(
              'Create',
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            SizedBox(height: 15),
            GlobalTextField(
              controller: locationController,
              labelText: 'Location',
              prefixIcon: Icons.location_city_outlined,
            ),
            SizedBox(height: 20),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.date_range,
                      color: Colors.blue,
                    ),
                    SizedBox(width: 5),
                    Text(
                      'Trip date',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: dateController,
                  style: TextStyle(color: white),
                  decoration: InputDecoration(
                    labelText: 'Date',
                    filled: true,
                    labelStyle: TextStyle(color: Colors.white),
                    fillColor: primaryColor,
                    prefixIcon: Icon(Icons.calendar_today, color: blue),
                    enabledBorder:
                        OutlineInputBorder(borderSide: BorderSide(color: blue)),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: blue, width: 2.0),
                    ),
                    disabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: blue, width: 2.0),
                    ),
                  ),
                  readOnly: true,
                  onTap: () {
                    _selectDate();
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _selectDate() async {
    try {
      DateTime? picked = await showDatePicker(
        context: context,
        firstDate: widget.trip.startDate,
        lastDate: widget.trip.endDate,
      );

      if (picked != null) {
        setState(() {
          dateController.text = DateFormat('dd MMM yyyy').format(picked);
        });
      }
    } catch (e) {
      log('Error while selecting dates: $e');
    }
  }
}
