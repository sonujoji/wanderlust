import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_floating_button.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class BudgetPage extends StatefulWidget {
  final Trip trip;
  const BudgetPage({super.key, required this.trip});

  @override
  State<BudgetPage> createState() => _BudgetPageState();
}

class _BudgetPageState extends State<BudgetPage> {
  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            child: Container(
              // height: screenHeight * 0.20,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: grey, borderRadius: BorderRadius.circular(5)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 13, vertical: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    CustomText(
                      text: 'Total Expence',
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                    ),
                    CustomText(
                      text: '₹45000',
                      color: blue,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )
                  ],
                ),
              ),
            ),
          ),
          // Center(
          //   child: CustomText(
          //     text: 'Add your budgets here',
          //     fontSize: 20,
          //     color: white,
          //   ),
          // ),
        ],
      ),
      backgroundColor: primaryColor,
      floatingActionButton: CustomFloatingButton(
        onPressed: () {},
      ),
    );
  }
}
