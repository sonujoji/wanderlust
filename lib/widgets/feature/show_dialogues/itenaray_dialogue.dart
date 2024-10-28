import 'package:flutter/material.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_snackbar.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
import 'package:wanderlust/widgets/global/custom_textfield.dart';

class ItenarayDialogue {
  final BuildContext context;
  final Function(String) addItenerary;
  late TextEditingController iteneraryTextController;

  ItenarayDialogue({required this.context, required this.addItenerary}) {
    iteneraryTextController = TextEditingController();
  }

  void addItenerairesDialogue() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: secondaryColor,
            title: CustomText(text: 'Add your plans'),
            content: GlobalTextField(
              controller: iteneraryTextController,
              labelText: 'Itenerary',
              prefixIcon: Icons.map_outlined,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: CustomText(text: 'Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (iteneraryTextController.text.isNotEmpty) {
                    addItenerary(iteneraryTextController.text);
                    Navigator.pop(context, iteneraryTextController.text);
                  } else {
                    customSnackBar(context, 'Enter your plans for the day');
                  }
                },
                child: CustomText(text: 'Add'),
              ),
            ],
          );
        });
  }
}
