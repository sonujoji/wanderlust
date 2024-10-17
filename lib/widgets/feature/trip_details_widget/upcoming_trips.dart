import 'dart:io';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';

class ListTrips extends StatelessWidget {
  final Trip trip;
  final int index;
   ListTrips({required this.trip,required this.index, super.key});
  TripService _tripService = TripService();
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.file(
                File(trip.destinationImage),
                fit: BoxFit.cover,
                height: 180,
                width: double.infinity,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 10, right: 10, left: 10, bottom: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '📍${trip.title}, ${trip.country}',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '💸 ₹${trip.budget} ',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' 📅 ${DateFormat('dd-MM-yyyy').format(trip.startDate)} - ${DateFormat('dd-MM-yyyy').format(trip.endDate)}',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '👥 ${trip.travellorCount} ',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
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
      Positioned(
        top: 20,
        right: 20,
        child: LikeButton(
          isLiked: trip.isFavorite,
          onTap: (isLiked) async {
            trip.isFavorite = !isLiked;
            await _tripService.updateTrip(index, trip);
            await _tripService.getTripDetails();
            return !isLiked;
          },
          likeBuilder: (bool isLiked) {
            return Icon(
              Icons.favorite,
              color: isLiked ? Colors.red : Colors.white,
              size: 35,
            );
          },
        ),
      ),
    ]);
  }
}
