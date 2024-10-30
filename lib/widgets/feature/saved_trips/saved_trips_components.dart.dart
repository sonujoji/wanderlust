import 'dart:io';

import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/trip_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class SavedTripsComponent extends StatefulWidget {
  final Trip trip;
  final int index;
  const SavedTripsComponent(
      {super.key, required this.trip, required this.index});

  @override
  State<SavedTripsComponent> createState() => _SavedTripsComponentState();
}

class _SavedTripsComponentState extends State<SavedTripsComponent> {
  final TripService _tripService = TripService();
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      height: screenHeight * 0.15,
      margin: EdgeInsets.only(top: screenHeight * 0.015),
      width: double.infinity,
      decoration: BoxDecoration(
          color: grey, borderRadius: BorderRadius.circular(screenWidth * 0.05)),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.all(screenWidth * 0.02),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(screenWidth * 0.04),
              child: Image.file(
                File(widget.trip.destinationImage),
                width: screenWidth * 0.40,
                height: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(width: screenWidth * 0.03),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: widget.trip.title,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    CustomText(
                      text: widget.trip.country!,
                      fontSize: 13,
                    ),
                    CustomText(
                      text: '₹${widget.trip.budget}',
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.04),
                  child: LikeButton(
                    size: 35,
                    isLiked: widget.trip.isFavorite,
                    onTap: (isLiked) async {
                      widget.trip.isFavorite = !isLiked;
                      await widget.trip.save();
                      await _tripService.getTripDetails();
                      return !isLiked;
                    },
                    likeBuilder: (isLiked) {
                      return Icon(
                          isLiked ? Icons.bookmark : Icons.bookmark_border,
                          color: isLiked ? Colors.red : Colors.white);
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
