import 'package:flutter/material.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_floating_button.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class DocumentsPage extends StatefulWidget {
  final Trip trip;
  const DocumentsPage({super.key,required this.trip});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: CustomText(
          text: 'Add your documents here',
          fontSize: 25,
          color: white,
        ),
      ),
      backgroundColor: primaryColor,
      floatingActionButton: CustomFloatingButton(
        onPressed: () {},
      ),
    );
  }
}
