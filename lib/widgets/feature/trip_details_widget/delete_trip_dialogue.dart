import 'package:flutter/material.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class DeleteTripDialogue extends StatelessWidget {
  final int index;
  final Future<void> Function(int) onDelete;
  DeleteTripDialogue({required this.index, required this.onDelete, super.key});
  final TripService _tripService = TripService();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 49, 52, 73),
      title: const CustomText(
        text: 'Do you want to delete trip',
        fontSize: 20,
      ),
      actions: [
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: CustomText(text: 'Cancel')),
        TextButton(
            onPressed: () async {
              await onDelete(index);
              customSnackBar(context, 'Trip deleted');
              Navigator.pop(context);
              await _tripService.getTripDetails();
            },
            child: const CustomText(text: 'Ok')),
      ],
    );
  }
}
