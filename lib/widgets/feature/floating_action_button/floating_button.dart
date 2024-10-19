import 'package:flutter/material.dart';
import 'package:wanderlust/widgets/feature/trip_details_widget/add_trip.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => const AddTripPage()));
      },
      backgroundColor: Colors.blue,
      child: const Icon(
        Icons.add,
      ),
    );
  }
}
