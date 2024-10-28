import 'dart:io';

import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class DetailedDocView extends StatelessWidget {
  final String imagePath;
  const DetailedDocView({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: PhotoView(
        imageProvider: FileImage(File(imagePath)),
        minScale: PhotoViewComputedScale.contained,
        maxScale: PhotoViewComputedScale.covered * 2,
      ),
    ));
  }
}
