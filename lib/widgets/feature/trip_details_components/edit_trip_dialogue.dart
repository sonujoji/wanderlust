import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/screens/pages/home.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/feature/bottom_navbar/bottom_navbar.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';

class EditTripDialog extends StatefulWidget {
  final Trip trip;
  final int index;
  EditTripDialog({super.key, required this.trip, required this.index});

  @override
  // ignore: library_private_types_in_public_api
  _EditTripDialogState createState() => _EditTripDialogState();
}

class _EditTripDialogState extends State<EditTripDialog> {
  late TextEditingController placeController;
  late TextEditingController countryController;
  late TextEditingController descriptionController;
  late TextEditingController budgetController;
  late TextEditingController travellorsController;
  late File updatedImage;
  late DateTimeRange dateRange;
  final TripService _tripService = TripService();

  void initializeControllers() {
    placeController = TextEditingController(text: widget.trip.title);
    countryController = TextEditingController(text: widget.trip.country);
    descriptionController =
        TextEditingController(text: widget.trip.description);
    budgetController =
        TextEditingController(text: widget.trip.budget.toString());
    travellorsController =
        TextEditingController(text: widget.trip.travellorCount.toString());
  }

  @override
  void initState() {
    super.initState();
    initializeControllers();
    updatedImage = File(widget.trip.destinationImage);
    dateRange = DateTimeRange(
      start: widget.trip.startDate,
      end: widget.trip.endDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: primaryColor,
      title: const CustomText(text: 'Edit Trip Details'),
      content: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 10),
            GlobalTextField(
              controller: placeController,
              labelText: 'Place',
              prefixIcon: Icons.place,
            ),
            const SizedBox(height: 10),
            GlobalTextField(
              controller: countryController,
              labelText: 'Country',
              prefixIcon: Icons.flag,
            ),
            const SizedBox(height: 10),
            GlobalTextField(
              controller: descriptionController,
              labelText: 'Description',
              maxLines: 3,
              prefixIcon: Icons.description,
            ),
            const SizedBox(height: 10),
            GlobalTextField(
              controller: budgetController,
              labelText: 'Budget',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.money,
            ),
            const SizedBox(height: 10),
            GlobalTextField(
              controller: travellorsController,
              labelText: 'No of Travelers',
              keyboardType: TextInputType.number,
              prefixIcon: Icons.group,
            ),
            const SizedBox(height: 10),
            dateSelector(),
            const SizedBox(height: 10),
            imageSelector(),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: CustomText(text: 'Cancel'),
        ),
        TextButton(
          onPressed: updateTrip,
          child: const CustomText(text: 'Update Trip'),
        ),
      ],
    );
  }

  Widget dateSelector() {
    return Column(
      children: [
        Row(
          children: [
            const Icon(Icons.date_range_outlined, color: Colors.blue),
            const SizedBox(width: 5),
            CustomText(text: 'Select the dates', fontWeight: FontWeight.bold),
            const SizedBox(width: 5),
          ],
        ),
        SizedBox(height: 5),
        Row(
          children: [
            TextButton(
              onPressed: () async {
                DateTimeRange? newDateRange = await showDateRangePicker(
                  context: context,
                  initialDateRange: dateRange,
                  firstDate: DateTime(2024),
                  lastDate: DateTime(2050),
                );
                if (newDateRange != null) {
                  setState(() => dateRange = newDateRange);
                }
              },
              child: CustomText(
                text:
                    '${DateFormat('dd-MM-yyyy').format(dateRange.start)}  to  ${DateFormat('dd-MM-yyyy').format(dateRange.end)}',
                color: Colors.blue,
              ),
            ),
          ],
        )
      ],
    );
  }

  Widget imageSelector() {
    return GestureDetector(
      onTap: () async {
        final pickedFile =
            await ImagePicker().pickImage(source: ImageSource.gallery);
        setState(() {
          updatedImage = File(pickedFile!.path);
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: Image.file(updatedImage, fit: BoxFit.cover)),
      ),
    );
  }

  void updateTrip() async {
    final updatedTrip = Trip(
    id: widget.trip.id,
      title: placeController.text,
      description: descriptionController.text,
      budget: int.parse(budgetController.text),
      startDate: dateRange.start,
      endDate: dateRange.end,
      travellorCount: int.parse(travellorsController.text),
      country: countryController.text,
      destinationImage: updatedImage.path,
    );
    await _tripService.updateTrip(widget.index, updatedTrip);
    setState(() {});
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => HomeScreen()),
      (Route<dynamic> route) => false,
    );
    customSnackBar(context, 'Trip updated successfully');
    await _tripService.getTripDetails();
  }
}

