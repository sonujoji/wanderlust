import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:wanderlust/service/doc_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';

class DetailedDocView extends StatelessWidget {
  final String imagePath;
  final String documentId;
  DetailedDocView(
      {super.key, required this.imagePath, required this.documentId});
  DocService _docService = DocService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.black,
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: white,
            ),
          ),
          actions: [
            IconButton(
                onPressed: () async {
                  bool confirmDelete = await showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            backgroundColor: secondaryColor,
                            title: CustomText(
                                text: 'Do you want to delete the document'),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(false);
                                  },
                                  child: CustomText(text: 'No')),
                              TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(true);
                                  },
                                  child: CustomText(text: 'Yes')),
                            ],
                          ));
                  if (confirmDelete == true) {
                    await _docService.deleteDocument(documentId);

                    Navigator.pop(context, true);
                  }
                },
                icon: Icon(
                  Icons.delete,
                  color: white,
                ))
          ],
        ),
        body: Center(
          child: PhotoView(
            imageProvider: FileImage(File(imagePath)),
            minScale: PhotoViewComputedScale.contained,
            maxScale: PhotoViewComputedScale.covered * 2,
          ),
        ));
  }
}
