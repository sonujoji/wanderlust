import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wanderlust/models/trip.dart';
import 'package:wanderlust/service/doc_service.dart';
import 'package:wanderlust/utils/colors.dart';
import 'package:wanderlust/screens/sub_screens/detailed_doc_page.dart';
import 'package:wanderlust/widgets/global/custom_floating_button.dart';
import 'package:wanderlust/widgets/global/custom_text.dart';
import 'Package:photo_view/photo_view.dart';

class DocumentsPage extends StatefulWidget {
  final String tripId;
  const DocumentsPage({super.key, required this.tripId});

  @override
  State<DocumentsPage> createState() => _DocumentsPageState();
}

class _DocumentsPageState extends State<DocumentsPage> {
  final ImagePicker _picker = ImagePicker();
  final DocService _docService = DocService();
  List<String> imagePaths = [];
  List<String> documentIds = [];

  @override
  void initState() {
    _loadDocuments();
    super.initState();
  }

  Future<void> _loadDocuments() async {
    await _docService.openBox();
    final docs = await _docService.getDocsByTripid(widget.tripId);
    setState(() {
      imagePaths = docs.expand((doc) => doc.photos).toList();
      documentIds = docs.map((doc) => doc.id).toList();
    });
    documentsListNotifier.value = docs;
    documentsListNotifier.notifyListeners();
  }

  Future<void> _pickandSaveImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      for (XFile image in images) {
        final newDocument = Documents(
          photos: [image.path],
          id: DateTime.now().millisecondsSinceEpoch.toString(),
          tripId: widget.tripId,
        );
        log('[${image.path}]');
        await _docService.addDocuments(newDocument);
      }
      await _loadDocuments();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: documentsListNotifier,
      builder: (context, docs, _) {
        return Scaffold(
          body: imagePaths.isEmpty
              ? Center(
                  child: CustomText(
                    text: 'Add your documents here',
                    fontSize: 18,
                    color: white,
                  ),
                )
              : GridView.builder(
                  itemCount: imagePaths.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 5,
                      mainAxisSpacing: 5),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () async {
                        bool? documentDeleted = await Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DetailedDocView(
                                      imagePath: imagePaths[index],
                                      documentId: documentIds[index],
                                    )));

                        if (documentDeleted == true) {
                          await _loadDocuments();
                        }
                      },
                      child: Image.file(
                        File(imagePaths[index]),
                        fit: BoxFit.cover,
                      ),
                    );
                  }),
          backgroundColor: primaryColor,
          floatingActionButton: CustomFloatingButton(
            onPressed: () {
              _pickandSaveImages();
            },
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _docService.closeBox();
    super.dispose();
  }
}
