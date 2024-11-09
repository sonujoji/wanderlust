import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';

import 'package:wanderlust/widgets/global/custom_text.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';

class EditPlanDialogue {
  final BuildContext context;
  final Function(String) addplan;

  late TextEditingController editPlanController;

  EditPlanDialogue({required this.context, required this.addplan}) {
    editPlanController = TextEditingController();
  }

  void showEditPlanDialogue() {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: secondaryColor,
            title: CustomText(
                text: "Add Plans",
                //  fontSize: screenWidth * 0.02,
                fontWeight: FontWeight.bold),
            content: GlobalTextField(
              controller: editPlanController,
              labelText: "Add your plan",
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: CustomText(
                      text: "Cancel",
                      // fontSize: screenWidth * 0.015,
                      fontWeight: FontWeight.w600)),
              TextButton(
                  onPressed: () {
                    if (editPlanController.text.isNotEmpty) {
                      addplan(editPlanController.text);
                    }
                    Navigator.of(context).pop();
                    customSnackBar(context, 'new plan added');
                  },
                  child: CustomText(
                      text: "Add",
                      // fontSize: screenWidth * 0.015,
                      fontWeight: FontWeight.w600))
            ],
          );
        });
  }
}
