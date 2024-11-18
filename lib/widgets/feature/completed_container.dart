import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
import 'package:wanderlust/widgets/global/empty_dialogue.dart';

class CompletedTripDetailsContainer extends StatelessWidget {
  final Trip trip;
  const CompletedTripDetailsContainer({super.key, required this.trip});

  @override
  Widget build(BuildContext context) {
    final startDate = DateFormat('MMM d').format(trip.startDate);
    final endDate = DateFormat('MMM d').format(trip.endDate);
    return Container(
      width: double.infinity,
      decoration:
          BoxDecoration(color: grey, borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: '📍${trip.country!.toUpperCase()}'),
                CustomText(text: '👤 ${trip.travellorCount}')
              ],
            ),
            SizedBox(height: 5),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(text: 'Started : $startDate'),
                CustomText(text: 'Completed : $endDate'),
              ],
            ),
            SizedBox(height: 5),
            Text(
              trip.description,
              style: TextStyle(
                color: white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ContainerButton extends StatelessWidget {
  final Trip trip;
  final String text;
  final double width;

  const ContainerButton(
      {super.key, required this.trip, required this.text, required this.width});

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Container(
      height: screenHeight * 0.045,
      width: screenWidth * width,
      decoration:
          BoxDecoration(color: blue, borderRadius: BorderRadius.circular(20)),
      child: Center(
          child: CustomText(
        text: text,
        fontWeight: FontWeight.w500,
      )),
    );
  }
}

class GalleryView extends StatelessWidget {
  final List<String> imagePaths;
  const GalleryView({super.key, required this.imagePaths});

  @override
  Widget build(BuildContext context) {
    return imagePaths.isEmpty
        ? EmptyDialogue(
            topPadding: 15,
            imagePath: 'assets/images/memories.png',
            text: 'Add memories to view here')
        : MasonryGridView.builder(
            itemCount: imagePaths.length,
            shrinkWrap: true,
            primary: false,
            gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (context) {
                        return Dialog(
                          backgroundColor: Colors.transparent,
                          child: PhotoView(
                              backgroundDecoration:
                                  BoxDecoration(color: Colors.transparent),
                              imageProvider: FileImage(
                                File(
                                  imagePaths[index],
                                ),
                              )),
                        );
                      });
                },
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.file(File(imagePaths[index])),
                  ),
                ),
              );
            },
          );
  }
}
