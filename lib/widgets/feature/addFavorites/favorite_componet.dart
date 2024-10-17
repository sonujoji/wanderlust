import 'package:flutter/material.dart';
import 'package:like_button/like_button.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class FavoriteComponent extends StatelessWidget {
  const FavoriteComponent({super.key});

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
              child: Image.asset(
                'assets/images/pexels-pixabay-237272.jpg',
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
                const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: ' Taj Mahal',
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                    CustomText(
                      text: '📍Delhi',
                      fontSize: 14,
                    ),
                    CustomText(
                      text: '💸5000',
                      fontSize: 14,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: screenWidth * 0.04),
                  child: const LikeButton(
                    size: 35,
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
