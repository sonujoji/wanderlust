import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

Widget animatedContainerWidget({
  required selectTab,
  required index,
  required BuildContext context,
  required day,
  required date,
}) {
  double screenWidth = MediaQuery.of(context).size.width;
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 4),
    child: AnimatedContainer(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeOut,
        width: selectTab == index ? 90 : 70,
        height: 50,
        decoration: BoxDecoration(
            color: selectTab == index ? blue : secondaryColor,
            borderRadius: BorderRadius.circular(10)),
        child: selectTab == index
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: day,
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                  Text(
                    DateFormat('dd MMM').format(date),
                    style: TextStyle(color: white, fontWeight: FontWeight.w600),
                  ),
                ],
              )
            : Center(
                child: CustomText(
                  text: day,
                  fontSize: 15,
                ),
              )),
  );
}
