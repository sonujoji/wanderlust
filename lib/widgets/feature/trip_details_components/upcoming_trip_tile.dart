import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:like_button/like_button.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';

class ListUpcomingTrips extends StatefulWidget {
  final Trip trip;
  final int index;
  const ListUpcomingTrips({required this.trip, required this.index, super.key});

  @override
  State<ListUpcomingTrips> createState() => _ListUpcomingTripsState();
}

class _ListUpcomingTripsState extends State<ListUpcomingTrips> {
  final TripService _tripService = TripService();

  @override
  Widget build(BuildContext context) {
    final DateFormat dateFormat = DateFormat('MMM-dd-yyyy');
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
                File(widget.trip.destinationImage),
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
                        '📍${widget.trip.title}, ${widget.trip.country}',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '💸 ₹${widget.trip.budget} ',
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
                        ' 📅 ${dateFormat.format(widget.trip.startDate)} - ${dateFormat.format(widget.trip.endDate)}',
                        style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                      Text(
                        '👥 ${widget.trip.travellorCount} ',
                        style: const TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  // Text(
                  //   ' 🗺️ ${widget.trip.description}',
                  //   style: const TextStyle(
                  //       fontSize: 14,
                  //       color: Colors.white,
                  //       fontWeight: FontWeight.w500),
                  // ),
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
          isLiked: widget.trip.isFavorite,
          onTap: (isLiked) async {
            try {
              widget.trip.isFavorite = !isLiked;

              await widget.trip.save();
             // await _tripService.updateTrip(widget.index, widget.trip);
              await _tripService.getTripDetails();
              return !isLiked;
            } catch (e) {
              log("Error updating fav status: $e");
              return isLiked;
            }
          },
          likeBuilder: (isLiked) {
            return Icon(
              isLiked ? Icons.bookmark : Icons.bookmark_border,
              color: isLiked ? Colors.red : Colors.white,
              size: 30,
            );
          },
        ),
      ),
    ]);
  }
}
